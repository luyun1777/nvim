return {
	-- Dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config) -- "dashboard", "theta"
		end,
	},
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "Bufenter",
		config = function()
			require("lualine").setup({})
		end,
	},
	-- Tabline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "BufEnter",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, _, _)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
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
						{
							filetype = "Aerial",
							text = "Outline",
							text_align = "center",
							separator = true,
						},
					},
				},
			})
			-- stylua: ignore start
			vim.keymap.set("", "gb", "<cmd>BufferLinePick<cr>", { silent = true, noremap = true, desc = "Pick buffer" })
			vim.keymap.set( "", "[b", "<cmd>BufferLineCyclePrev<cr>", { silent = true, noremap = true, desc = "Prev buffer" })
			vim.keymap.set( "", "]b", "<cmd>BufferLineCycleNext<cr>", { silent = true, noremap = true, desc = "Next buffer" })
			vim.keymap.set( "", "bmp", "<cmd>BufferLineMovePrev<cr>", { silent = true, noremap = true, desc = "Move buffer prev" })
			vim.keymap.set( "", "bmn", "<cmd>BufferLineMoveNext<cr>", { silent = true, noremap = true, desc = "Move buffer next" }
			)
		end,
		-- stylua: ignore end
	},
	-- Winbar
	-- {
	-- 	"Bekaboo/dropbar.nvim",
	-- 	enable = vim.fn.has("nvim-0.10.0") == 1,
	-- 	config = function()
	-- 		local api = require("dropbar.api")
	-- 		vim.keymap.set("n", "<Leader>;", api.pick)
	-- 		vim.keymap.set("n", "[c", api.goto_context_start)
	-- 		vim.keymap.set("n", "]c", api.select_next_context)

	-- 		local confirm = function()
	-- 			local menu = api.get_current_dropbar_menu()
	-- 			if not menu then
	-- 				return
	-- 			end
	-- 			local cursor = vim.api.nvim_win_get_cursor(menu.win)
	-- 			local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
	-- 			if component then
	-- 				menu:click_on(component)
	-- 			end
	-- 		end

	-- 		local quit_curr = function()
	-- 			local menu = api.get_current_dropbar_menu()
	-- 			if menu then
	-- 				menu:close()
	-- 			end
	-- 		end

	-- 		require("dropbar").setup({
	-- 			menu = {
	-- 				-- When on, automatically set the cursor to the closest previous/next
	-- 				-- clickable component in the direction of cursor movement on CursorMoved
	-- 				quick_navigation = true,
	-- 				---@type table<string, string|function|table<string, string|function>>
	-- 				keymaps = {
	-- 					["<LeftMouse>"] = function()
	-- 						local menu = api.get_current_dropbar_menu()
	-- 						if not menu then
	-- 							return
	-- 						end
	-- 						local mouse = vim.fn.getmousepos()
	-- 						if mouse.winid ~= menu.win then
	-- 							local parent_menu = api.get_dropbar_menu(mouse.winid)
	-- 							if parent_menu and parent_menu.sub_menu then
	-- 								parent_menu.sub_menu:close()
	-- 							end
	-- 							if vim.api.nvim_win_is_valid(mouse.winid) then
	-- 								vim.api.nvim_set_current_win(mouse.winid)
	-- 							end
	-- 							return
	-- 						end
	-- 						menu:click_at({ mouse.line, mouse.column }, nil, 1, "l")
	-- 					end,
	-- 					["<CR>"] = confirm,
	-- 					["i"] = confirm,
	-- 					["<esc>"] = quit_curr,
	-- 					["q"] = quit_curr,
	-- 					["n"] = quit_curr,
	-- 					["<MouseMove>"] = function()
	-- 						local menu = api.get_current_dropbar_menu()
	-- 						if not menu then
	-- 							return
	-- 						end
	-- 						local mouse = vim.fn.getmousepos()
	-- 						if mouse.winid ~= menu.win then
	-- 							return
	-- 						end
	-- 						menu:update_hover_hl({ mouse.line, mouse.column - 1 })
	-- 					end,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"xiyaowong/transparent.nvim",
	-- 	cmd = { "TransparentEnable", "TransparentDisable", "TransparentToggle" },
	-- 	keys = { "<leader>t" },
	-- 	config = function()
	-- 		if vim.fn.has("win") ~= nil then
	-- 			return
	-- 		end
	-- 		require("transparent").setup({
	-- 			extra_groups = {
	-- 				"NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
	-- 				"NvimTreeNormal", -- NvimTree
	-- 			},
	-- 			-- 	exclude_groups = {}, -- table: groups you don't want to clear
	-- 		})
	-- 		require("transparent").clear_prefix("BufferLine")
	-- 		require("transparent").clear_prefix("NvimTree")
	-- 		require("transparent").clear_prefix("lualine")
	-- 		vim.g.transparent_groups = vim.list_extend(
	-- 			vim.g.transparent_groups or {},
	-- 			vim.tbl_map(function(v)
	-- 				return v.hl_group
	-- 			end, vim.tbl_values(require("bufferline.config").highlights))
	-- 		)
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>t",
	-- 			"<cmd>TransparentToggle<cr>",
	-- 			{ silent = true, nowait = true, noremap = true, desc = "TransparentToggle" }
	-- 		)
	-- 		vim.cmd([[TransparentEnable]])
	-- 	end,
	-- },
	-- Better notification
	{
		"rcarriga/nvim-notify",
		config = function()
			-- vim.o.cmdheight = 0
			local notify = require("notify")
			vim.notify = notify
			notify.setup({
				fps = 60,
				render = "compact", -- "defalut", "minimal", "simple", "compact","warpped-compact"
				-- background_colour = "#000000",
			})
			vim.keymap.set("n", "<leader>fn", function()
				require("telescope").extensions.notify.notify({
					-- layout_strategy = "vertical",
					-- layout_config = {
					-- 	width = 0.9,
					-- 	height = 0.9,
					-- 	preview_height = 0.1,
					-- },
					-- wrap_results = true,
					-- previewer = false,
				})
			end, { noremap = true, silent = true, desc = "Find notification" })
			vim.keymap.set(
				"n",
				"<LEADER>nc",
				require("notify").dismiss,
				{ noremap = true, silent = true, desc = "Close notification" }
			)
		end,
	},
	{
		"folke/noice.nvim",
		event = "BufEnter",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = false, -- long messages will be sent to a split
					-- inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature
				},
			})
			vim.o.cmdheight = 0
			vim.keymap.set({ "n", "i", "s" }, "<c-d>", function()
				if not require("noice.lsp").scroll(4) then
					return "<c-d>"
				end
			end, { silent = true, expr = true })
			vim.keymap.set({ "n", "i", "s" }, "<c-u>", function()
				if not require("noice.lsp").scroll(-4) then
					return "<c-u>"
				end
			end, { silent = true, expr = true })
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("dressing").setup({
				input = { default_prompt = "➤ " },
				select = { backend = { "telescope", "builtin", "nui" } },
			})
		end,
	},
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	event = "LspAttach",
	-- 	config = function()
	-- 		require("fidget").setup({})
	-- 	end,
	-- },
}
