return {
	-- Comment
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = function()
				vim.g.skip_ts_context_commentstring_module = true
				require("ts_context_commentstring").setup({
					enable_autocmd = false,
				})
			end,
		},
		keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
		config = function()
			require("Comment").setup({
				ignore = "^$",
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "User LazyLoad",
		config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme(Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        },
	},

	-- Indent
	-- {
	-- 	"shellRaining/hlchunk.nvim",
	-- 	event = "User LazyLoad",
	-- 	config = function()
	-- 		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL" })
	-- 		require("hlchunk").setup({
	-- 			indent = { chars = { "│", "¦", "┆", "┊" }, use_treesitter = false },
	-- 			blank = { enable = false },
	-- 			line_num = { use_treesitter = true },
	-- 		})
	-- 	end,
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User LazyLoad",
		main = "ibl",
		opts = {
			indent = {
				char = "|",
				tab_char = { "│", "¦", "┆", "┊" },
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"NvimTree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
	},
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "User LazyLoad",
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"NvimTree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		cmd = "ConformInfo",
		event = "BufWritePre",
        -- stylua: ignore
        keys = {
            { "<leader>cF", function() require("conform").format({ formatters = { "injected" }, async = true }) end, desc = "Format Injected File", },
            { "<leader>cf", function() require("conform").format({ lsp_fallback = true, async = true }) end, desc = "Format file", },
        },
		opts = {
			format = { timeout_ms = 3000, async = true, quiet = true, lsp_fallback = true },
			format_on_save = { async = true, lsp_fallback = true },
			formatters = { injected = { options = { ignore_errors = true } } },
			formatters_by_ft = {
				css = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				jsonc = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" }, "injected" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				java = { "clang-format" },
				javascript = { { "prettierd", "prettier" } },
				rust = { "rustfmt" },
				typescript = { { "prettierd", "prettier" } },
				lua = { "stylua" },
				python = { "isort", "black" },
				yaml = { "yamlfix" },
			},
		},
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		event = "User LazyLoad",
		opts = {
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {
				python = { "flake8", "mypy" },
			},
		},
		config = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- Project mangagement
	-- {
	-- 	"ahmedkhalf/project.nvim",
	-- 	event = "User LazyLoad",
	-- 	config = function()
	-- 		require("project_nvim").setup({})
	-- 		require("telescope").load_extension("projects")
	-- 		vim.keymap.set(
	-- 			{ "n" },
	-- 			"<leader>fp",
	-- 			"<cmd>lua require'telescope'.extensions.projects.projects{}<cr>",
	-- 			{ silent = true, noremap = true, desc = "Find recent project" }
	-- 		)
	-- 	end,
	-- },

	-- Outline
	{
		"stevearc/aerial.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle aerial" },
			{ "<leader>O", "<cmd>AerialNavToggle<CR>", desc = "Toggle aerial nav" },
		},
		cmd = { "AerialToggle", "AerialNavToggle", "AerialPrev", "AerialNext" },
		opts = {
			layout = { width = 30 },
			close_automatic_events = { "unfocus", "switch_buffer", "unsupported" },
			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Field",
				"Function",
				"Interface",
				"Method",
				"Module",
				"Namespace",
				"Package",
				"Property",
				"Struct",
				"Trait",
			},
			keymaps = { ["<tab>"] = "actions.tree_toggle" },
			highlight_on_hover = true,
			autojump = true,
			close_on_select = false,
			show_guides = true,
		},
	},
	-- {
	-- 	"hedyhli/outline.nvim",
	-- 	cmd = { "Outline", "OutlineOpen" },
	-- 	keys = { { "<leader>o", "<cmd>Outline<CR>", mode = { "n" }, desc = "Toggle Outline" } },
	-- 	config = function()
	-- 		require("outline").setup({
	-- 			outline_window = {
	-- 				position = "right",
	-- 				auto_close = true,
	-- 				auto_jump = true,
	-- 				focus_on_open = true,
	-- 			},
	-- 			outline_items = { show_symbol_details = false },
	-- 			providers = { priority = { "lsp", "markdown", "coc", "norg" } },
	-- 			symbols = { icon_source = "lspkind" },
	-- 		})
	-- 	end,
	-- },
}
