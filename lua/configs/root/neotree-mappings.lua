return {
	default = {
		["<space>"] = {
			"toggle_node",
			nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
		},
		["<2-LeftMouse>"] = "open",
		["<cr>"] = "open",
		["<esc>"] = "cancel", -- close preview or floating neo-tree window
		["P"] = { "toggle_preview", config = { use_float = true } },
		["l"] = "open",
		["S"] = "open_split",
		["s"] = "open_vsplit",
		-- ["S"] = "split_with_window_picker",
		-- ["s"] = "vsplit_with_window_picker",
		["t"] = "open_tabnew",
		-- ["<cr>"] = "open_drop",
		-- ["t"] = "open_tab_drop",
		["w"] = "open_with_window_picker",
		--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
		["C"] = "close_node",
		-- ['C'] = 'close_all_subnodes',
		["z"] = "close_all_nodes",
		--["Z"] = "expand_all_nodes",
		["a"] = {
			"add",
			-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
			-- some commands may take optional config options, see `:h neo-tree-mappings` for details
			config = {
				show_path = "none", -- "none", "relative", "absolute"
			},
		},
		["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
		["d"] = "delete",
		["r"] = "rename",
		["y"] = "copy_to_clipboard",
		["x"] = "cut_to_clipboard",
		["p"] = "paste_from_clipboard",
		["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
		-- ["c"] = {
		--  "copy",
		--  config = {
		--    show_path = "none" -- "none", "relative", "absolute"
		--  }
		--}
		["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
		["q"] = "close_window",
		["R"] = "refresh",
		["?"] = "show_help",
		["<"] = "prev_source",
		[">"] = "next_source",
		["i"] = "show_file_details",
	},
	filesystem = {
		["<bs>"] = "navigate_up",
		["."] = "set_root",
		["H"] = "toggle_hidden",
		["/"] = "fuzzy_finder",
		["D"] = "fuzzy_finder_directory",
		["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
		-- ["D"] = "fuzzy_sorter_directory",
		["f"] = "filter_on_submit",
		["<c-x>"] = "clear_filter",
		["[g"] = "prev_git_modified",
		["]g"] = "next_git_modified",
		["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
		["oc"] = { "order_by_created", nowait = false },
		["od"] = { "order_by_diagnostics", nowait = false },
		["og"] = { "order_by_git_status", nowait = false },
		["om"] = { "order_by_modified", nowait = false },
		["on"] = { "order_by_name", nowait = false },
		["os"] = { "order_by_size", nowait = false },
		["ot"] = { "order_by_type", nowait = false },
	},
	fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
		["<down>"] = "move_cursor_down",
		["<C-n>"] = "move_cursor_down",
		["<up>"] = "move_cursor_up",
		["<C-p>"] = "move_cursor_up",
	},
	buffers = {
		["bd"] = "buffer_delete",
		["<bs>"] = "navigate_up",
		["."] = "set_root",
		["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
		["oc"] = { "order_by_created", nowait = false },
		["od"] = { "order_by_diagnostics", nowait = false },
		["om"] = { "order_by_modified", nowait = false },
		["on"] = { "order_by_name", nowait = false },
		["os"] = { "order_by_size", nowait = false },
		["ot"] = { "order_by_type", nowait = false },
	},
	git_status = {
		["A"] = "git_add_all",
		["gu"] = "git_unstage_file",
		["ga"] = "git_add_file",
		["gr"] = "git_revert_file",
		["gc"] = "git_commit",
		["gp"] = "git_push",
		["gg"] = "git_commit_and_push",
		["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
		["oc"] = { "order_by_created", nowait = false },
		["od"] = { "order_by_diagnostics", nowait = false },
		["om"] = { "order_by_modified", nowait = false },
		["on"] = { "order_by_name", nowait = false },
		["os"] = { "order_by_size", nowait = false },
		["ot"] = { "order_by_type", nowait = false },
	},
	misc = function()
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }
		map("n", "<leader>ngs", ":Neotree float git_status<CR>", opts) -- open git status window
	end,
}
