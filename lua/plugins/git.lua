return {
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable("git") == 1,
		cmd = "Gitsigns",
		keys = { { "<leader>g", mode = { "n", "v" }, desc = "Toggle gitsigns" } },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
			vim.keymap.set("n", "<leader>g-", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>g=", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "[g", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "]g", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>gl", ":Gitsigns blame_line<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk_inline<CR>", { noremap = true, silent = true })
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		enabled = vim.fn.executable("git") == 1 and vim.fn.executable("lazygit") == 1,
		keys = {
			{ "<leader>gg", ":LazyGit<CR>", mode = { "n" }, desc = "Toggle lazygit" },
		},
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 1.0
			vim.g.lazygit_floating_window_winblend = 0
			vim.g.lazygit_use_neovim_remote = true
		end,
	},
	-- {
	-- 	"APZelos/blamer.nvim",
	-- 	config = function()
	-- 		vim.g.blamer_enabled = true
	-- 		vim.g.blamer_relative_time = true
	-- 	end
	-- }
}
