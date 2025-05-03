local autogroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- auto cmd height
local AdjustCmdHeight = autogroup("AdjustCmdHeight", { clear = true })
autocmd("CmdlineEnter", {
    group = AdjustCmdHeight,
    pattern = "*",
    command = "set cmdheight=1"
})
autocmd("CmdlineLeave", {
    group = AdjustCmdHeight,
    pattern = "*",
    command = "set cmdheight=0"
})
