return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = {
			"TSInstall",
			"TSUninstall",
			"TSUpdate",
			"TSInstallInfo",
		},
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		keys = {
			{ "<cr>", desc = "Increment Selection" },
			{ "<bs>", desc = "Decrement Selection", mode = "x" },
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- vim.o.foldmethod = "expr"
			-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
			require("nvim-treesitter.configs").setup({
				autotag = { enable = true },
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<cr>",
						node_incremental = "<cr>",
						node_decremental = "<bs>",
						scope_incremental = "<tab>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						goto_next_start = { ["]m"] = "@function.outer", ["]z"] = "@fold" },
						goto_next_end = { ["]M"] = "@function.outer", ["]Z"] = "@fold" },
						goto_previous_start = { ["[m"] = "@function.outer", ["[z"] = "@fold" },
						goto_previous_end = { ["[M"] = "@function.outer", ["[Z"] = "@fold" },
						goto_next = { ["]C"] = "@class.outer" },
						goto_previous = { ["[C"] = "@class.outer" },
					},
					swap = {
						enable = true,
						swap_next = { ["<leader>a"] = "@parameter.inner" },
						swap_previous = { ["<leader>A"] = "@parameter.inner" },
					},
					lsp_interop = {
						enable = true,
						border = "rounded",
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
				ensure_installed = {
					"bash",
					"c",
					"lua",
					"json",
					"jsonc",
					"markdown",
					"markdown_inline",
					"python",
					"rust",
					"query",
					"regex",
					"vim",
					"vimdoc",
					"yaml",
				},
			})
		end,
	},
}
