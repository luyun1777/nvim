return {
	"saghen/blink.cmp",
	envent = "VeryLazy",
	version = "1.*",
	dependencies = {
		-- {
		-- 	"L3MON4D3/LuaSnip",
		-- 	version = "v2.*",
		-- 	config = function()
		-- 		require("luasnip.loaders.from_vscode").lazy_load()
		-- 	end,
		-- },
		{ "rafamadriz/friendly-snippets" },
		{ "onsails/lspkind.nvim" },
	},

	opts = {
		-- snippets = { preset = "luasnip" },
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Enter>"] = { "accept", "fallback" },
		},
		cmdline = {
			enabled = true,
			keymap = {
				["<cr>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
			completion = {
				menu = { auto_show = true },
				list = { selection = { preselect = false, auto_insert = true } },
			},
		},
		completion = {
			documentation = { auto_show = true },
			list = { selection = { preselect = false, auto_insert = true } },
			menu = {
				auto_show = true,
				draw = {
					treesitter = { "lsp" },
					components = {
						kind_icon = {
							text = function(ctx)
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbol_map[ctx.kind] or ""
								end

								return icon .. ctx.icon_gap
							end,

							highlight = function(ctx)
								local hl = ctx.kind_hl
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end
								return hl
							end,
						},
					},
				},
			},
		},

		sources = {
			default = { "lsp", "lazydev", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100, -- show at a higher priority than lsp
				},
			},
		},
	},
}
