return {
	-- Comment
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = function()
				vim.g.skip_ts_context_commentstring_module = true
				require("ts_context_commentstring").setup({ enable_autocmd = false })
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
            { "<leader>cf", function() require("conform").format({  timeout_ms = 3000, async = true, quiet = true, lsp_format = "fallback" }) end, desc = "Format file", },
        },
		opts = {
			format_after_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 3000, async = true, quiet = true, lsp_format = "fallback" }
			end,
			formatters = { injected = { options = { ignore_errors = true } } },
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				java = { "clang-format" },
				javascript = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				jsonc = { { "prettierd", "prettier" } },
				lua = { "stylua" },
				markdown = { { "prettierd", "prettier" }, "injected" },
				python = { "ruff_organize_imports", "ruff_format", "ruff_fix" },
				rust = { "rustfmt" },
				typescript = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				["_"] = { "trim_whitespace" },
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
				python = { "ruff" },
				-- Use the "*" filetype to run linters on all filetypes.
				-- ['*'] = { 'global linter' },
				-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
				-- ['_'] = { 'fallback linter' },
				-- ["*"] = { "typos" },
			},
		},
		config = function(_, opts)
			local M = {}

			local lint = require("lint")
			lint.linters_by_ft = opts.linters_by_ft

			function M.debounce(ms, fn)
				local timer = vim.uv.new_timer()
				return function(...)
					local argv = { ... }
					timer:start(ms, 0, function()
						timer:stop()
						vim.schedule_wrap(fn)(unpack(argv))
					end)
				end
			end

			function M.lint()
				local names = lint._resolve_linter_by_ft(vim.bo.filetype)

				names = vim.list_extend({}, names)

				if #names == 0 then
					vim.list_extend(names, lint.linters_by_ft["_"] or {})
				end

				vim.list_extend(names, lint.linters_by_ft["*"] or {})

				local ctx = { filename = vim.api.nvim_buf_get_name(0) }
				ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
				names = vim.tbl_filter(function(name)
					local linter = lint.linters[name]
					if not linter then
						vim.notify("Linter not found: " .. name, vim.log.levels.WARN, { title = "nvim-lint" })
					end
					return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
				end, names)

				if #names > 0 then
					lint.try_lint(names)
				end
			end

			vim.api.nvim_create_autocmd(opts.events, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = M.debounce(100, M.lint),
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
