return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = { { "<leader>f", desc = "Toggle Telescope" } },
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = (function()
				if vim.fn.executable("make") == 0 then
					return
				end
				return "make"
			end)(),
		},
		"stevearc/dressing.nvim",
	},
	config = function()
		local ts = require("telescope")
		local builtin = require("telescope.builtin")
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
				color_devicons = true,
				prompt_prefix = "🔍 ",
				selection_caret = " ",
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-h>"] = "which_key",
						["<esc>"] = "close",
						["<C-f>"] = "results_scrolling_down",
						["<C-b>"] = "results_scrolling_up",
						["<Tab>"] = "move_selection_worse",
						["<S-Tab>"] = "move_selection_better",
						["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
						["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
						["<Down>"] = "cycle_history_next",
						["<Up>"] = "cycle_history_prev",
						["<C-s-v"] = "paste_register",
					},
				},
			},
			pickers = {
				buffers = {
					show_all_buffers = true,
					sort_lastused = true,
					mappings = { i = { ["<c-d>"] = actions.delete_buffer } },
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
		vim.keymap.set("n", "<leader>fM", builtin.reloader, { desc = "List lua modules (reload)" })

		vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "List git commits" })
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "List git branches" })
		vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "List git status" })
		vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "List git stash" })
	end,
}
