return {
	-- Dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = true,
		init = false,
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", "<cmd>Telescope find_files<cr>"),
				dashboard.button("n", " " .. " New file", "<cmd>ene<BAR>startinsert<cr>"),
				dashboard.button("r", " " .. " Recent files", "<cmd>Telescope oldfiles<cr>"),
				dashboard.button("g", " " .. " Find text", "<cmd>Telescope live_grep<cr>"),
				dashboard.button("s", " " .. " Restore Session", [[<cmd>lua require("persistence").load()<cr>]]),
				dashboard.button("l", "󰒲 " .. " Lazy", "<cmd>Lazy<cr>"),
				dashboard.button("q", " " .. " Quit", "<cmd>qa<cr>"),
			}
			dashboard.opts.layout[1].val = 5
			return dashboard
		end,
		config = function(_, dashboard)
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					once = true,
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				once = true,
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		opts = {},
	},
	-- Tabline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		},
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local icons = require("util.static").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				show_buffer_close_icons = false,
				show_close_icon = false,
				enforce_regular_tabs = true,
				show_duplicate_prefix = false,
				separator_style = "thick",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						highlight = "Directory",
						separator = true,
					},
				},
			},
		},
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		config = function()
			if vim.fn.has("win") == 1 then
				return
			end
			require("transparent").setup({
				extra_groups = { "NormalFloat", "NvimTreeNormal" },
			})
			require("transparent").clear_prefix("BufferLine")
			require("transparent").clear_prefix("NvimTree")
			require("transparent").clear_prefix("lualine")
			vim.g.transparent_groups = vim.list_extend(
				vim.g.transparent_groups or {},
				vim.tbl_map(function(v)
					return v.hl_group
				end, vim.tbl_values(require("bufferline.config").highlights))
			)
		end,
	},

	-- Better notification
	{
		"rcarriga/nvim-notify",
        -- stylua: ignore
		keys = {
			{ "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss All Notifications", },
			{ "<leader>fn", function() require("telescope").extensions.notify.notify({}) end, desc = "Find notification", },
		},
		opts = {
			render = "compact", -- "defalut", "minimal", "simple", "compact","warpped-compact"
			background_colour = "#000000",
		},
		init = function()
			vim.notify = require("notify")
		end,
	},
	{
		"folke/noice.nvim",
		event = "BufEnter",
        -- stylua: ignore
        keys = {
            { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
            { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
        },
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = false,
				lsp_doc_border = true,
			},
		},
		init = function()
			vim.o.cmdheight = 0
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = { default_prompt = "➤ " },
			select = { backend = { "telescope", "builtin", "nui" } },
		},
	},
}
