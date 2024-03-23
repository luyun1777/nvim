return {
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm" },
		keys = { [[<c-\>]], [[<leader>tt]], [[<leader>tf]], [[<leader>th]], [[<leader>tv]], desc = "Toggle ToggleTerm" },
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				direction = "float",
				shading_factor = 2,
				float_opts = { border = "curved" },
			})
			vim.keymap.set("", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
			vim.keymap.set("", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle ToggleTerm" })
			vim.keymap.set(
				"",
				"<leader>th",
				"<cmd>ToggleTerm size=15 direction=horizontal<cr>",
				{ desc = "ToggleTerm horizontal" }
			)
			vim.keymap.set(
				"",
				"<leader>tv",
				"<cmd>ToggleTerm size=50 direction=vertical<cr>",
				{ desc = "ToggleTerm vertical" }
			)
		end,
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
				ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			})
		end,
	},
}
