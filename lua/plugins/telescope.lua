return {
	"nvim-telescope/telescope.nvim",
	lazy = true,
	cmd = "Telescope",
	keys = { { "<leader>f", desc = "Toggle Telescope" } },
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
		"stevearc/dressing.nvim",
		-- -- "nvim-telescope/telescope-ui-select.nvim",
		-- 'dimaportenko/telescope-simulators.nvim',
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = "Find colorscheme" })
		vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Find registers" })
		vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, { desc = "Spell suggestion" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymap" })
		vim.keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find, { desc = "Find current buffer" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find recent file" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
		vim.keymap.set("n", "<leader>fl", builtin.builtin, { desc = "List built-in pickers" })
		vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "List symbols from Treesitter" })
		vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Find marks" })
		vim.keymap.set("n", "<leader>fM", builtin.reloader, { desc = "List lua modules" })

		vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "List git commits" })
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "List git branches" })
		vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "List git status" })
		vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "List git stash" })

		local ts = require("telescope")
		local actions = require("telescope.actions")
		ts.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--fixed-strings",
					"--smart-case",
					"--trim",
				},
				layout_config = {
					width = 0.9,
					height = 0.9,
				},
				mappings = {
					i = {
						["<C-h>"] = "which_key",
						["<C-u>"] = "move_selection_previous",
						["<C-d>"] = "move_selection_next",
						["<C-l>"] = "preview_scrolling_up",
						["<C-y>"] = "preview_scrolling_down",
						["<esc>"] = "close",
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
					},
				},
				color_devicons = true,
				prompt_prefix = "🔍 ",
				selection_caret = " ",
				path_display = { "truncate" },
			},
			pickers = {
				buffers = {
					show_all_buffers = true,
					sort_lastused = true,
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer,
						},
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})
		ts.load_extension("fzf")
	end,
}
