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
				ensure_installed = {
					"bash",
					"c",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"rust",
					"query",
					"regex",
					"vim",
					"vimdoc",
				},
				auto_install = vim.fn.executable("tree-sitter") == 1,
				highlight = {
					enable = true,
					disable = function(_, bufnr)
						return vim.b[bufnr].large_buf
					end,
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
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]o"] = "@loop.outer",
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
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
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
}
