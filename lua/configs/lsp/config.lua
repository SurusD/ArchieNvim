-- Helper function to create LSP-specific keymaps
local function map(keys, func, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, keys, func, { buffer = 0, desc = "LSP: " .. desc })
end

-- Function to check if the LSP client supports a method
local function client_supports_method(client, method)
	---@diagnostic disable-next-line: param-type-mismatch
	local ok, result = pcall(vim.lsp.protocol.Methods[method], client, method)
	return ok and result
end

-- Autocommand to configure LSP on attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
	callback = function(event)
		local buf = event.buf
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- Cache method checks to avoid redundant calls
		local supports_document_highlight = client_supports_method(client, "textDocument/documentHighlight")
		local supports_inlay_hint = client_supports_method(client, "textDocument/inlayHint")

		-- Keymaps for LSP actions
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame", { "n" })
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
		map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
		map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
		map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

		-- Highlight references under cursor
		if supports_document_highlight then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" }, {
				buffer = buf,
				group = vim.api.nvim_create_augroup("lsp_highlight", { clear = true }),
				callback = function()
					vim.lsp.buf.document_highlight()
					vim.lsp.buf.clear_references()
				end,
			})
		end

		-- Toggle inlay hints
		if supports_inlay_hint then
			map("<leader>th", function()
				---@diagnostic disable-next-line: param-type-mismatch
				vim.lsp.inlay_hint.enable(buf, not vim.lsp.inlay_hint.is_enabled(buf))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

-- Diagnostic configuration
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			return diagnostic.message
		end,
	},
})

-- LSP capabilities
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Load and configure LSP servers
local servers = (function()
	local servers_path = vim.fn.stdpath("config") .. "/lua/configs/lsp/servers/"
	local servers = vim.fn.glob(servers_path .. "*.lua")
	if type(servers) == "string" then
		servers = { servers }
	end
	local compiled = {}
	for _, file in pairs(servers) do
		local filename = vim.fn.fnamemodify(file, ":t:r")
		compiled[filename] = require("configs.lsp.servers." .. filename)
	end
	return compiled
end)()

-- Ensure servers and tools are installed
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, { "stylua" })
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
	ensure_installed = {},
	automatic_installation = false,
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})
