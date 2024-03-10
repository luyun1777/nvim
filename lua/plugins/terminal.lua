return {
	{
		"akinsho/toggleterm.nvim",
		cmd = {
			"ToggleTerm",
		},
		keys = { [[<c-\>]], [[<leader>tt]], [[<leader>tf]], [[<leader>th]], [[<leader>tv]], desc = "Toggle ToggleTerm" },
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				direction = "float",
				shading_factor = 2,
				float_opts = {
					border = "curved",
				},
			})
			vim.keymap.set("", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
			vim.keymap.set({ "n", "t", "v", "s" }, "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle ToggleTerm" })
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
			-- vim.keymap.set({ "n", "i" }, "<c-enter>", function()
			-- require("toggleterm").send_lines_to_terminal("single_line", false, { args = vim.v.count })
			-- end)
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
	-- {
	-- 	"willothy/flatten.nvim",
	-- 	-- lazy = false,
	-- 	-- priority = 1001,
	-- 	config = function()
	-- 		local saved_terminal
	-- 		require("flatten").setup({
	-- 			window = {
	-- 				open = "alternate",
	-- 			},
	-- 			callbacks = {
	-- 				should_block = require("flatten").default_should_block,
	-- 				should_nest = require("flatten").default_should_nest,
	-- 				pre_open = function()
	-- 					local term = require("toggleterm.terminal")
	-- 					local termid = term.get_focused_id()
	-- 					saved_terminal = term.get(termid)
	-- 				end,
	-- 				post_open = function(bufnr, winnr, ft, is_blocking)
	-- 					if is_blocking and saved_terminal then
	-- 						saved_terminal:close()
	-- 					else
	-- 						vim.api.nvim_set_current_win(winnr)
	-- 						-- Requires willothy/wezterm.nvim
	-- 						-- require("wezterm").switch_pane.id(tonumber(os.getenv("WEZTERM_PANE")))
	-- 					end
	-- 					if ft == "gitcommit" or ft == "gitrebase" then
	-- 						vim.api.nvim_create_autocmd("BufWritePost", {
	-- 							buffer = bufnr,
	-- 							once = true,
	-- 							callback = vim.schedule_wrap(function()
	-- 								vim.api.nvim_buf_delete(bufnr, {})
	-- 							end),
	-- 						})
	-- 					end
	-- 				end,
	-- 				block_end = function()
	-- 					vim.schedule(function()
	-- 						if saved_terminal then
	-- 							saved_terminal:open()
	-- 							saved_terminal = nil
	-- 						end
	-- 					end)
	-- 				end,
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
