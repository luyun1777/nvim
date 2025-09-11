return {
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm" },
		keys = {
			{ "<c-t>" },
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle ToggleTerm" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
			{ "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "ToggleTerm horizontal" },
			{ "<leader>tv", "<cmd>ToggleTerm direction=vertical size=50<cr>", desc = "ToggleTerm vertical" },
			-- { "<leader>gg", "<cmd>lua Toggle_Lazygit()<cr>", desc = "ToggleTerm Lazygit" },
		},
		opts = {
			direction = "float",
			shading_factor = 2,
			float_opts = { border = "curved" },
			open_mapping = [[<c-t>]],
		},
		-- init = function()
		-- 	local Terminal = require("toggleterm.terminal").Terminal

		-- 	local _lazygit = Terminal:new({ cmd = "lazygit", hidden = true, dir = "git_dir", direction = "float" })

		-- 	function Toggle_Lazygit()
		-- 		if vim.fn.executable("lazygit") == 1 then
		-- 			_lazygit:toggle()
		-- 		else
		-- 			vim.notify("**lazygit** is not founded in PATH, please install it.", vim.log.levels.WARN)
		-- 		end
		-- 	end
		-- end,
	},
	-- {
	-- 	"Vigemus/iron.nvim",
	-- 	keys = {
	-- 		{ "<leader>i", vim.cmd.IronRepl, desc = "󱠤 Toggle REPL" },
	-- 		{ "<leader>I", vim.cmd.IronRestart, desc = "󱠤 Restart REPL" },
	-- 		{ "<leader>sl", desc = "󱠤 Send Line to REPL" },
	-- 		{ "<leader>sf", desc = "󱠤 Send File to REPL" },
	-- 	},
	-- 	config = function()
	-- 		local iron = require("iron.core")
	-- 		iron.setup({
	-- 			config = {
	-- 				repl_definition = {
	-- 					sh = { command = { "zsh" } },
	-- 				},
	-- 				repl_open_cmd = "horizontal bot 20 split",
	-- 			},
	-- 			keymaps = {
	-- 				send_file = "<leader>sf",
	-- 				send_line = "<leader>sl",
	-- 				exit = "<leader>sq",
	-- 			},
	-- 			ignore_blank_lines = true,
	-- 		})
	-- 	end,
	-- },
}
