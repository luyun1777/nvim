return {
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable("git") == 1,
		cmd = "Gitsigns",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				preview_config = { border = "rounded" },
				-- show_deleted = true,
				on_attach = function(bufnr)
					local map = vim.keymap.set
					local opts = { buffer = bufnr, noremap = true, silent = true }
					map("n", "<leader>g-", "<cmd>Gitsigns prev_hunk<CR>", opts)
					map("n", "<leader>g=", "<cmd>Gitsigns next_hunk<CR>", opts)
					map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", opts)
					map("n", "]g", "<cmd>Gitsigns next_hunk<CR>", opts)
					map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", opts)
					map("n", "<leader>gl", "<cmd>Gitsigns toggle_linehl<CR>", opts)
					map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts)
					map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", opts)
					map("n", "<leader>gd", "<cmd>Gitsigns toggle_deleted<CR>", opts)
				end,
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		enabled = vim.fn.executable("git") == 1 and vim.fn.executable("lazygit") == 1,
		cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter" },
		keys = { "<leader>gG", { "<leader>gg", "<cmd>LazyGit<CR>", mode = { "n" }, desc = "Toggle lazygit" } },
		config = function()
			require("telescope").load_extension("lazygit")
			vim.keymap.set("n", "<leader>gG", "<cmd>lua require('telescope').extensions.lazygit.lazygit()<cr>")
		end,
	},
}
