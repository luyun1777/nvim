return {
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {},
	},
	-- Tabline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
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
	-- Winbar
	-- {
	-- 	"Bekaboo/dropbar.nvim",
	-- 	enabled = vim.fn.has("nvim-0.10") == 1,
	-- 	dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
	-- 	opts = {},
	-- },
	-- {
	-- 	"xiyaowong/transparent.nvim",
	-- 	cmd = { "TransparentEnable", "TransparentDisable", "TransparentToggle" },
	-- 	keys = { { "<leader>ut", "<cmd>TransparentToggle<cr>", desc = "Toggle Background Transparent" } },
	-- 	config = function()
	-- 		require("transparent").setup({
	-- 			extra_groups = { "NormalFloat", "NvimTreeNormal" },
	-- 		})
	-- 		require("transparent").clear_prefix("BufferLine")
	-- 		-- require("transparent").clear_prefix("lualine")
	-- 	end,
	-- },

	-- Better notification
	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	event = "VeryLazy",
	--        -- stylua: ignore
	-- 	keys = {
	-- 		{ "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss All Notifications", },
	-- 	},
	-- 	opts = {
	-- 		render = "compact", -- "defalut", "minimal", "simple", "compact","warpped-compact"
	-- 		-- background_colour = "#000000",
	-- 	},
	-- 	init = function()
	-- 		vim.notify = require("notify")
	-- 	end,
	-- },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
            { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
			{ "<leader>sn", "<cmd>Noice history<cr>", desc = "Show Notifications History", },
			{ "<leader>un", "<cmd>Noice dismiss<cr>", desc = "Dismiss all messages", },
        },
		-- dependencies = {
		-- 	"MunifTanjim/nui.nvim",
		-- "rcarriga/nvim-notify",
		-- },
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
}
