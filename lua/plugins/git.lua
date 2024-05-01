return {
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable("git") == 1,
		cmd = "Gitsigns",
		event = { "BufReadPost", "VeryLazy" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			preview_config = { border = "rounded" },
			current_line_blame = true,
			on_attach = function(bufnr)
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end
				map("n", "<leader>g-", "<cmd>Gitsigns prev_hunk<CR>", "Prev hunk")
				map("n", "<leader>g=", "<cmd>Gitsigns next_hunk<CR>", "Next hunk")
				map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", "Prev hunk")
				map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", "Next hunk")
				map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", "Blame line")
				map("n", "<leader>gl", "<cmd>Gitsigns toggle_linehl<CR>")
				map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk")
				map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk")
				map("n", "<leader>gd", "<cmd>Gitsigns toggle_deleted<CR>")
			end,
		},
	},
	{
		"kdheepak/lazygit.nvim",
		enabled = vim.fn.executable("git") == 1 and vim.fn.executable("lazygit") == 1,
		cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter" },
		keys = {
			{ "<leader>gG", "<cmd>Telescope lazygit<cr>", desc = "Telescope lazygit" },
			{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "Toggle lazygit" },
		},
	},
}
