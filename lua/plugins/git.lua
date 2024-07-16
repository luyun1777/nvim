return {
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable("git") == 1,
		cmd = "Gitsigns",
		event = "User LazyLoad",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			preview_config = { border = "rounded" },
			-- current_line_blame = true,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

                -- stylua: ignore start
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
				map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
				map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk")
				map({ "n", "v" }, "<leader>gR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>gB", function() gs.blame() end, "Blame Buffer")
				map("n", "<leader>gd", gs.diffthis, "Diff This")
				map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
	-- {
	-- 	"kdheepak/lazygit.nvim",
	-- 	enabled = vim.fn.executable("git") == 1 and vim.fn.executable("lazygit") == 1,
	-- 	cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter" },
	-- 	keys = {
	-- 		{ "<leader>gG", "<cmd>Telescope lazygit<cr>", desc = "Telescope lazygit" },
	-- 		{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "Toggle lazygit" },
	-- 	},
	-- },
}
