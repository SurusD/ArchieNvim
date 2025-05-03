return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<C-n>",
			function()
				require("configs.root.neotree")
                vim.cmd [[Neotree toggle]]
			end,
            noremap = true,
            silent = true
		},
	},
}
