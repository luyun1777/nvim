return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		opts = {
			transparent_background = true,
			float = { transparent = true },
			term_colors = true,
			auto_integrations = true,
		},
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		opts = {
			-- transparent_mode = true,
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
}
