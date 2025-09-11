return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- TODO:主分支将由`master`更变为`main`与之前不兼容
		branch = "master",
		cmd = {
			"TSInstall",
			"TSUninstall",
			"TSUpdate",
			"TSInstallInfo",
			"TSInstallFromGrammar",
		},
		event = "User LazyLoad",
		keys = {
			{ "<cr>", desc = "Increment Selection" },
			{ "<bs>", desc = "Decrement Selection", mode = "x" },
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		-- config = function()
		-- 	local nvim_treesitter = require("nvim-treesitter")
		-- 	nvim_treesitter.setup()

		-- 	local ensure_installed = {
		-- 		"lua",
		-- 		"toml",
		-- 		"bash",
		-- 		"c",
		-- 		"lua",
		-- 		"json",
		-- 		"jsonc",
		-- 		"markdown",
		-- 		"markdown_inline",
		-- 		"python",
		-- 		"rust",
		-- 		"query",
		-- 		"regex",
		-- 		"vim",
		-- 		"vimdoc",
		-- 		"yaml",
		-- 	}
		-- 	local pattern = {}
		-- 	for _, parser in ipairs(ensure_installed) do
		-- 		-- neovim 自己的 api，找不到这个 parser 会报错
		-- 		local has_parser, _ = pcall(vim.treesitter.language.inspect, parser)

		-- 		if not has_parser then
		-- 			-- install 是 nvim-treesitter 的新 api，默认情况下无论是否安装 parser 都会执行，所以这里我们做一个判断
		-- 			nvim_treesitter.install(parser)
		-- 		else
		-- 			-- 新版本需要手动启动高亮，但没有安装相应 parser会导致报错
		-- 			pattern = vim.tbl_extend("keep", pattern, vim.treesitter.language.get_filetypes(parser))
		-- 		end
		-- 	end
		-- 	vim.api.nvim_create_autocmd("FileType", {
		-- 		pattern = pattern,
		-- 		callback = function()
		-- 			vim.treesitter.start()
		-- 			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		-- 		end,
		-- 	})
		-- 	-- VeryLazy 晚于 FileType，所以需要手动触发一下
		-- 	vim.api.nvim_exec_autocmds("FileType", {})
		-- end,
		config = function()
			-- vim.o.foldmethod = "expr"
			-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
			require("nvim-treesitter.configs").setup({
				modules = {},
				sync_install = false,
				ignore_install = {},
				auto_install = false,
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
					"html",
					"json",
					"jsonc",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"rust",
					"query",
					"regex",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "User LazyLoad",
		opts = {},
	},
}
