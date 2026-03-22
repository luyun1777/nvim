return {
	-- Comment
	{
		"numToStr/Comment.nvim",
		enabled = vim.fn.has("nvim-0.10.0") == 0,
		keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
		opts = { ignore = "^$" },
	},
	{
		"folke/ts-comments.nvim",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		event = { "BufRead", "BufNewFile" },
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble" },
		event = { "BufRead", "BufNewFile" },
		opts = {},
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
            { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
        },
	},
	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {
			win = {},
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},
	-- Indent
	-- {
	-- 	"shellRaining/hlchunk.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		indent = { enable = true, chars = { "│", "¦", "┆", "┊" }, use_treesitter = false },
	-- 		blank = { enable = false },
	-- 		line_num = { use_treesitter = true },
	-- 	},
	-- },
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	event = "VeryLazy",
	-- 	main = "ibl",
	-- 	opts = {
	-- 		indent = {
	-- 			char = "|",
	-- 			tab_char = { "│", "¦", "┆", "┊" },
	-- 		},
	-- 		scope = { enabled = false },
	-- 		exclude = {
	-- 			filetypes = {
	-- 				"help",
	-- 				"alpha",
	-- 				"dashboard",
	-- 				"NvimTree",
	-- 				"Trouble",
	-- 				"trouble",
	-- 				"lazy",
	-- 				"mason",
	-- 				"notify",
	-- 				"toggleterm",
	-- 				"lazyterm",
	-- 			},
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"echasnovski/mini.indentscope",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		symbol = "│",
	-- 		options = { try_as_border = true },
	-- 	},
	-- 	init = function()
	-- 		vim.api.nvim_create_autocmd("FileType", {
	-- 			pattern = {
	-- 				"help",
	-- 				"alpha",
	-- 				"dashboard",
	-- 				"NvimTree",
	-- 				"Trouble",
	-- 				"trouble",
	-- 				"lazy",
	-- 				"mason",
	-- 				"notify",
	-- 				"toggleterm",
	-- 				"lazyterm",
	-- 			},
	-- 			callback = function()
	-- 				vim.b.miniindentscope_disable = true
	-- 			end,
	-- 		})
	-- 	end,
	-- },

	-- Formatting
	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		event = "BufWritePre",
        -- stylua: ignore
        keys = {
            { "<leader>cF", function() require("conform").format({ formatters = { "injected" }, }) end, desc = "Format Injected File", },
            { "<leader>cf", function() require("conform").format() end, desc = "Format file", },
        },
		opts = {
			default_format_opts = { timeout_ms = 3000, async = true, quiet = true, lsp_format = "fallback" },
			format_after_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return {}
			end,
			formatters = { injected = { options = { ignore_errors = true } } },
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettier" },
				fish = { "fish_indent" },
				html = { "prettier" },
				java = { "clang-format" },
				javascript = { "prettier" },
				go = { "goimports", "gofmt" },
				json = { "prettier" },
				jsonc = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier", "injected" },
				python = { "ruff_organize_imports", "ruff_format" },
				r = { "air" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				tex = { "tex-fmt" },
				toml = { "tombi" },
				typescript = { "prettier" },
				yaml = { "prettier" },
				["_"] = { "trim_whitespace" },
			},
		},
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		event = { "BufRead", "BufNewFile" },
		opts = {
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {
				fish = { "fish" },
				python = { "ruff" },
				rust = { "clippy" },
				-- Use the "*" filetype to run linters on all filetypes.
				["*"] = { "typos" },
				-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
				-- ['_'] = { 'fallback linter' },
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
	-- 	event = "VeryLazy",
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
	-- 	opts = {
	-- 		outline_window = {
	-- 			position = "right",
	-- 			auto_close = true,
	-- 			auto_jump = true,
	-- 			focus_on_open = true,
	-- 		},
	-- 		outline_items = { show_symbol_details = false },
	-- 		providers = { priority = { "lsp", "markdown", "coc", "norg" } },
	-- 		symbols = { icon_source = "lspkind" },
	-- 	},
	-- },
}
