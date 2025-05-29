return {
	"saghen/blink.cmp",
	envent = "User LazyLoad",
	version = "1.*",
	dependencies = {
		-- { "L3MON4D3/LuaSnip", version = "v2.*" },
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
									icon = require("lspkind").symbolic(ctx.kind, {
										mode = "symbol",
									})
								end

								return icon .. ctx.icon_gap
							end,

							-- Optionally, use the highlight groups from nvim-web-devicons
							-- You can also add the same function for `kind.highlight` if you want to
							-- keep the highlight groups in sync with the icons.
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
