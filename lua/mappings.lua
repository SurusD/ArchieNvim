vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- exit insert/terminal mode
map({ "i", "t" }, "jk", "<cmd>stopinsert<CR>", opts)
-- delete a char without copying it
map("n", "x", '"_x', opts)
-- window splitting
map("n", "<leader>o", "<cmd>vsplit<CR>", { noremap = true, silent = true, desc = "Vertical window split" })
map("n", "<leader>h", "<cmd>split<CR>", { noremap = true, silent = true, desc = "Horizontal window split" })
-- window resizing with arrows
map("n", "<Up>", "<cmd>resize -2<CR>", opts)
map("n", "<Down>", "<cmd>resize +2<CR>", opts)
map("n", "<Left>", "<cmd>vertical resize +2<CR>", opts)
map("n", "<Right>", "<cmd>vertical resize -2<CR>", opts)
-- toggle line wrapping
map('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)
--- navigation
-- windows
map("n", "<C-h>", "<C-w>h", opts) -- focus to the left window
map("n", "<C-l>", "<C-w>l", opts) -- focus to the right window
map("n", "<C-j>", "<C-w>j", opts) -- focus bottom window
map("n", "<C-k", "<C-w>k", opts)  -- focus upper window
-- diagnostics
---@diagnostic disable-next-line: deprecated
map("n", "<leader>pd", vim.diagnostic.goto_prev, { desc = "Goto [p]revious [d]iagnostic", noremap = true, silent = true })
---@diagnostic disable-next-line: deprecated
map("n", "<leader>nd", vim.diagnostic.goto_next, { desc = "Goto [n]ext [d]iagnostic", noremap = true, silent = true })
map("n", "<leader>ad", vim.diagnostic.setloclist, { desc = "Show [a]ll [d]iagnostics", noremap = true, silent = true })
-- search
map("n", "n", "nzzzv", opts)                    -- find and center
map("n", "N", "Nzzzv", opts)                    -- find and center
-- buffers(bufferline tabs)
map("n", "<Tab>", "<cmd>bnext<CR>", opts)       -- next buffer(bufferline tab)
map("n", "<S-Tab>", "<cmd>bprevious<CR>", opts) -- previous buffer(bufferline tab)
map("n", "<leader>x", "<cmd>bdelete!<CR>",
    { noremap = true, silent = true, desc = "Delete current buffer(bufferline tab)" })
