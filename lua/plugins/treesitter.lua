return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = {
			"TSInstall",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
			"TSInstallInfo",
			"TSInstallSync",
			"TSInstallFromGrammar",
		},
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- "chrisgrieser/nvim-various-textobjs",
		},
		config = function()
			-- vim.o.foldmethod = "expr"
			-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
			require("nvim-treesitter.configs").setup({
				-- stylua: ignore start
				ensure_installed = {
					"bash", "c", "html", "java", "javascript", "lua", "markdown", "markdown_inline",
					"python", "query", "regex", "vim", "vimdoc", "yaml",
				},
				auto_install = false,
				highlight = {
					enable = true,
					disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<cr>", -- normal mode
						node_incremental = "<cr>", -- visual mode
						node_decremental = "<bs>", -- visual mode
						scope_incremental = "<tab>", -- visual mode
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["ar"] = "@return.outer",
							["ir"] = "@return.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]o"] = "@loop.outer",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]O"] = "@loop.outer",
							["]Z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[o"] = "@loop.outer",
							["[z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[O"] = "@loop.outer",
							["[Z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next = { ["]C"] = "@class.outer" },
						goto_previous = { ["[C"] = "@class.outer" },
					},
					swap = {
						enable = true,
						swap_next = {
							['<leader>a'] = '@parameter.inner',
						},
						swap_previous = {
							['<leader>A'] = '@parameter.inner',
						},
					},
					lsp_interop = {
						enable = true,
						border = "rounded",
						floating_preview_opts = {},
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
			})
		end,
	},
	--[[ {
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
			vim.keymap.set("n", "[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true })
		end
	} ]]
}
