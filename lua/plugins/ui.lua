return {
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		-- event = "VeryLazy",
		event = { "BufRead", "BufNewFile" },
		opts = {},
	},

	-- Tabline
	{
		"akinsho/bufferline.nvim",
		event = { "BufRead", "BufNewFile" },
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>bb", "<Cmd>BufferLinePick<CR>", desc = "BufferLine Pick" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
			{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning .. " " or "")
						.. (diag.hint and icons.Hint .. diag.hint .. " " or "")
						.. (diag.info and icons.Info .. diag.info or "")
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

	-- Better Notify
	{
		"folke/noice.nvim",
		event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
            { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"} },
			{ "<leader>sn", "<cmd>Noice history<cr>", desc = "Show Notifications History" },
			{ "<leader>un", "<cmd>Noice dismiss<cr>", desc = "Dismiss all messages" },
        },
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- "rcarriga/nvim-notify",
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
}
