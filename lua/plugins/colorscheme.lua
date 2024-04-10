return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				dim_inactive = true,
				-- transparent_mode = true,
			})
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	{ "arturgoms/moonbow.nvim", lazy = true },
	{ "Shatur/neovim-ayu", lazy = true },
	{ "ajmwagar/vim-deus", lazy = true, enabled = vim.fn.has("win32") == 1 },
	{ "theniceboy/nvim-deus", lazy = true, enabled = vim.fn.has("win32") ~= 1 },
}
