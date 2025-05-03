local mode = {
    "mode",
    fmt = function(str)
        return " " .. str
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
    end,
}

local filename = {
    "filename",
    file_status = true, -- displays file status (readonly status, modified status)
    path = 0,           -- 0 = just filename, 1 = relative path, 2 = absolute path
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    colored = false,
    update_in_insert = false,
    cond = function() return vim.fn.winwidth(0) > 100 end, -- directly include the condition here
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = function() return vim.fn.winwidth(0) > 100 end, -- directly include the condition here
}

require("lualine").setup({
    options = {
        icons_enabled = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "neo-tree" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { "branch" },
        lualine_c = { filename },
        lualine_x = { diagnostics, diff, { "encoding", cond = function() return vim.fn.winwidth(0) > 100 end }, { "filetype", cond = function() return
            vim.fn.winwidth(0) > 100 end } },
        lualine_y = { "location" },
        lualine_z = { "progress" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "location", padding = 0 } },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = { "fugitive" },
})
