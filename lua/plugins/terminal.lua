return {
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm" },
		keys = {
			{ "<c-/>", "<cmd>ToggleTerm<cr>", desc = "Toggle ToggleTerm" },
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle ToggleTerm" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
			{ "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "ToggleTerm horizontal" },
			{ "<leader>tv", "<cmd>ToggleTerm direction=vertical size=50<cr>", desc = "ToggleTerm vertical" },
		},
		opts = {
			direction = "float",
			shading_factor = 2,
			float_opts = { border = "curved" },
		},
	},
	{
		"Vigemus/iron.nvim",
		keys = {
			{ "<leader>i", vim.cmd.IronRepl, desc = "󱠤 Toggle REPL" },
			{ "<leader>I", vim.cmd.IronRestart, desc = "󱠤 Restart REPL" },
			{ "<c-enter>", desc = "󱠤 Send Line to REPL" },
			{ "<c-s-enter>", desc = "󱠤 Send File to REPL" },
		},
		config = function()
			local iron = require("iron.core")
			iron.setup({
				config = {
					repl_definition = {
						sh = { command = { "zsh" } },
					},
					repl_open_cmd = "horizontal bot 20 split",
				},
				keymaps = {
					visual_send = "<c-enter>",
					send_file = "<c-s-enter>",
					send_line = "<c-enter>",
					exit = "<leader>q",
				},
				ignore_blank_lines = true,
			})
		end,
	},
}
