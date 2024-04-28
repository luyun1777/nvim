return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"windwp/nvim-autopairs",
		{
			"yehuohan/cmp-im",
			keys = {
				{
					"<M-;>",
					function()
						vim.notify(string.format("IM is %s", require("cmp_im").toggle() and "enabled" or "disabled"))
					end,
					mode = { "n", "v", "c", "i" },
					desc = "Toggle cmp-im",
				},
			},
			dependencies = { "yehuohan/cmp-im-zh" },
			config = function()
				require("cmp_im").setup({ enable = false, tables = require("cmp_im_zh").tables({ "wubi" }) })
			end,
		},
		{
			"onsails/lspkind.nvim",
			config = function()
				require("lspkind").init()
			end,
		},
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				if vim.fn.has("win32") == 1 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				"rafamadriz/friendly-snippets",
				event = "InsertEnter",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
	},

	config = function()
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		local border_opts = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		}
		local has_words_before = function()
			local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#CCD6DD", fg = "NONE" })
		-- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

		cmp.setup({
			preselect = cmp.PreselectMode.None,

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
				{ name = "IM" },
			}),

			window = {
				completion = cmp.config.window.bordered(border_opts),
				documentation = cmp.config.window.bordered(border_opts),
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
					})(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = "    (" .. (strings[2] or "") .. ")"
					return kind
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<Space>"] = cmp.mapping(require("cmp_im").select(), { "i" }),
				["<CR>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
				}),
			}),
			-- experimental = { ghost_text = { hl_group = "CmpGhostText" } },
		})
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
