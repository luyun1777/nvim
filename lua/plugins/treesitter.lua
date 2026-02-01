return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		cmd = {
			"TSInstall",
			"TSInstallFromGrammar",
			"TSUpdate",
			"TSUninstall",
			"TSLog",
		},
		event = "VeryLazy",
		opts = {
			highlight = { enable = true },
			folds = { enable = true },
			indent = { enabled = true },
		},
		config = function(_, opts)
			local nvim_treesitter = require("nvim-treesitter")
			nvim_treesitter.setup(opts)

			local ensure_installed = {
				"bash",
				"c",
				"html",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"toml",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			}
			local pattern = {}
			for _, parser in ipairs(ensure_installed) do
				local has_parser, _ = pcall(vim.treesitter.language.inspect, parser)

				if not has_parser then
					nvim_treesitter.install(parser)
				else
					pattern = vim.tbl_extend("keep", pattern, vim.treesitter.language.get_filetypes(parser))
				end
			end
			vim.api.nvim_create_autocmd("FileType", {
				pattern = pattern,
				callback = function()
					vim.treesitter.start()
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldmethod = "expr"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				move = { set_jumps = true },
			})

			-- select
			vim.keymap.set({ "x", "o" }, "af", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
			end)

			-- swap
			vim.keymap.set("n", "<leader>a", function()
				require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
			end)
			vim.keymap.set("n", "<leader>A", function()
				require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
			end)

            -- stylua: ignore
            local moves = {  -- textobjects
                goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner", },
            }
			for method, keymaps in pairs(moves) do
				for key, query in pairs(keymaps) do
					local queries = type(query) == "table" and query or { query }
					local parts = {}
					for _, q in ipairs(queries) do
						local part = q:gsub("@", ""):gsub("%..*", "")
						part = part:sub(1, 1):upper() .. part:sub(2)
						table.insert(parts, part)
					end
					local desc = table.concat(parts, " or ")
					desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
					desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
					if not (vim.wo.diff and key:find("[cC]")) then
						vim.keymap.set({ "n", "x", "o" }, key, function()
							require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
						end, { desc = desc, silent = true })
					end
				end
			end
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		opts = {},
	},
}
