return {
	-- Comment
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			keys = { "<c-/>", "c-s-/" },
			config = function()
				vim.g.skip_ts_context_commentstring_module = true --skip backwards compatibility routines and speed up loading.
				require("ts_context_commentstring").setup({
					enable_autocmd = false,
				})
			end,
		},
		keys = {
			{ "<c-/>", mode = { "n", "v" }, desc = "Comment code (line)" },
			{ "<c-s-/>", mode = { "n", "v" }, desc = "Comment code (block)" },
		},
		config = function()
			require("Comment").setup({
				ignore = "^$",
				toggler = { line = "<c-/>", block = "<c-s-/>" },
				opleader = { line = "<c-/>", block = "<c-s-/>" },
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })
		end,
	},

	-- Indent
	{
		"shellRaining/hlchunk.nvim",
		event = "BufEnter",
		config = function()
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL" })
			require("hlchunk").setup({
				indent = { chars = { "│", "¦", "┆", "┊" }, use_treesitter = false },
				blank = { enable = false },
				line_num = { use_treesitter = true },
			})
		end,
	},
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	lazy = true,
	-- 	event = "BufEnter",
	-- 	main = "ibl",
	-- 	config = function()
	-- 		local highlight = {
	-- 			"RainbowRed",
	-- 			"RainbowYellow",
	-- 			"RainbowBlue",
	-- 			"RainbowOrange",
	-- 			"RainbowGreen",
	-- 			"RainbowViolet",
	-- 			"RainbowCyan",
	-- 		}
	-- 		local hooks = require("ibl.hooks")
	-- 		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	-- 			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	-- 			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	-- 			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	-- 			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	-- 			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	-- 			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	-- 			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
	-- 		end)

	-- 		vim.g.rainbow_delimiters = { highlight = highlight }
	-- 		require("ibl").setup({
	-- 			indent = {
	-- 				char = "|",
	-- 				tab_char = { "│", "¦", "┆", "┊" },
	-- 				-- highlight = { "Function", "Label" },
	-- 				-- highlight = highlight,
	-- 				smart_indent_cap = true,
	-- 				priority = 2,
	-- 				-- repeat_linebreak = false,
	-- 			},
	-- 			scope = {
	-- 				enabled = true,
	-- 				show_start = true,
	-- 				show_end = false,
	-- 				injected_languages = false,
	-- 				priority = 500,
	-- 				highlight = highlight,
	-- 				include = {
	-- 					node_type = {
	-- 						["*"] = {
	-- 							"if_statement",
	-- 							"for_statement",
	-- 							"while_statement",
	-- 							"return_statement",
	-- 							"table_constructor",
	-- 						},
	-- 						-- lua = { "return_statement", "table_constructor" },
	-- 						-- python = { "if_statement", "for_statement", "while_statement" },
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	-- 	end,
	-- },

	-- Formatting
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		cmd = "ConformInfo",
		event = "BufWritePre",
		keys = {
			{
				"<M-l>",
				function()
					require("conform").format({ lsp_fallback = true })
					-- require("conform").format({ formatters = { "injected" } })
				end,
				mode = { "n", "v" },
				desc = "Format file",
			},
		},
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
					-- formatters = { "injected" },
				},
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
					typescript = { { "prettierd", "prettier" } },
					lua = { "stylua" },
					python = { "isort", "black" },
					yaml = { { "prettierd", "prettier" } },
				},
				formatters = { injected = { options = { ignore_errors = true } } },
			})
		end,
	},

	-- Linting
	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
	-- 		linters_by_ft = {
	-- 			-- python = { "flake8" },
	-- 			-- Use the "*" filetype to run linters on all filetypes.
	-- 			-- ['*'] = { 'global linter' },
	-- 			-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
	-- 			-- ['_'] = { 'fallback linter' },
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	-- 			callback = function()
	-- 				require("lint").try_lint()
	-- 			end,
	-- 		})
	-- 	end,
	-- },

	-- Project mangagement
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
			require("project_nvim").setup({})
			require("telescope").load_extension("projects")
			vim.keymap.set(
				{ "n" },
				"<leader>fp",
				"<cmd>lua require'telescope'.extensions.projects.projects{}<cr>",
				{ silent = true, noremap = true, nowait = true, desc = "Find recent projects" }
			)
		end,
	},

	-- Outline
	{
		"stevearc/aerial.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle aerial" },
			{ "<leader>O", "<cmd>AerialNavToggle<CR>", desc = "Toggle aerial nav" },
		},
		cmd = { "AerialToggle", "AerialNavToggle", "AerialPrev", "AerialNext" },
		config = function()
			require("aerial").setup({
				layout = { width = 30 },
				close_automatic_events = { "unfocus", "switch_buffer", "unsupported" },
				-- "Array", "Boolean", "Class", "Constant", "Constructor", "Enum", "EnumMember", "Event", "Field", "File", "Function", "Interface", "Key", "Method", "Module", "Namespace", "Null", "Number", "Object", "Operator", "Package", "Property", "String", "Struct", "TypeParameter", "Variable",
				filter_kind = {
					"Class",
					"Property",
					"Constructor",
					"Enum",
					"Function",
					"Interface",
					"Module",
					"Method",
					"Struct",
				},
				keymaps = { ["<tab>"] = "actions.tree_toggle" },
				highlight_on_hover = true,
				autojump = true,
				close_on_select = false,
				show_guides = true,
			})
		end,
	},
	-- {
	-- 	"hedyhli/outline.nvim",
	-- 	lazy = true,
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

	-- Code runner
	{
		"CRAG666/code_runner.nvim",
		keys = { "<leader>rr", "<leader>rf" },
		config = function()
			require("code_runner").setup({
				filetype = {
					lua = "lua",
				},
			})
			-- stylua: ignore start
			vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = true, desc = "RunCode" })
			vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = true, desc = "RunFile" })
			vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = true, desc = "RunProject" })
			vim.keymap.set("n", "<leader>rq", ":RunClose<CR>", { noremap = true, silent = true, desc = "RunClose" })
			vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = true, desc = "CRFiletype" })
			vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = true, "CRProjects" })
			-- stylua: ignore end
		end,
	},
}
