return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			-- transparent_mode = true,
		},
		init = function()
			vim.cmd.colorscheme("gruvbox")
		end,
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
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		opts = {
			transparent_background = true,
			float = { transparent = true },
			term_colors = true,
			auto_integrations = true,
		},
	},
}
