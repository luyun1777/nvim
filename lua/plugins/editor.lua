return {
	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = true,
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
		keys = { { "tt", ":NvimTreeToggle<cr>", desc = "Toggle nvim-tree" } },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				disable_netrw = true,
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = { enable = true, update_root = true },
				-- sort = { sorter = "case_sensitive" },
				view = { width = 20 },
				renderer = { group_empty = true },
				-- filters = { dotfiles = true },
				vim.keymap.set("", "tt", ":NvimTreeToggle<cr>", { silent = true, nowait = true }),
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"kelly-lin/ranger.nvim",
		enable = vim.fn.executable("ranger") == 1,
		keys = { "<leader>ra" },
		config = function()
			require("ranger-nvim").setup({ replace_netrw = true, ui = { border = "rounded" } })
			vim.keymap.set("n", "<leader>ra", function()
				require("ranger-nvim").open(true)
			end, { noremap = true, silent = true })
		end,
	},
	-- Better move
	{
		"folke/flash.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = { rainbow = { enable = true } },
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
	-- Better fold
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		-- keys = { "zo", "zO", "zc", "zC", "za", "zA", "zv", "zx", "zX", "zm", "zM", "zr", "zR" },
		config = function()
			-- local handler = function(virtText, lnum, endLnum, width, truncate)
			-- 	local newVirtText = {}
			-- 	local suffix = (" 󰁂 %d "):format(endLnum - lnum)
			-- 	local sufWidth = vim.fn.strdisplaywidth(suffix)
			-- 	local targetWidth = width - sufWidth
			-- 	local curWidth = 0
			-- 	for _, chunk in ipairs(virtText) do
			-- 		local chunkText = chunk[1]
			-- 		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- 		if targetWidth > curWidth + chunkWidth then
			-- 			table.insert(newVirtText, chunk)
			-- 		else
			-- 			chunkText = truncate(chunkText, targetWidth - curWidth)
			-- 			local hlGroup = chunk[2]
			-- 			table.insert(newVirtText, { chunkText, hlGroup })
			-- 			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- 			-- str width returned from truncate() may less than 2nd argument, need padding
			-- 			if curWidth + chunkWidth < targetWidth then
			-- 				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			-- 			end
			-- 			break
			-- 		end
			-- 		curWidth = curWidth + chunkWidth
			-- 	end
			-- 	table.insert(newVirtText, { suffix, "MoreMsg" })
			-- 	return newVirtText
			-- end
			require("ufo").setup({
				provider_selector = function(_, filetype, buftype)
					return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
						or { "treesitter", "indent" } -- if file opened, try to use treesitter if available
				end,
				-- fold_virt_text_handler = handler,
			})
		end,
	},
	-- Better surrounding
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	-- ZenMode
	-- {
	-- 	"folke/zen-mode.nvim",
	-- 	cmd = "ZenMode",
	-- 	dependencies = { "folke/twilight.nvim" },
	-- 	keys = { "<leader>z", desc = "Toggle ZenMode" },
	-- 	config = function()
	-- 		vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { silent = true, nowait = true })
	-- 	end,
	-- },
	-- Better scroll
	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	envet = "VeryLazy",
	-- 	config = function()
	-- 		require("neoscroll").setup({})
	-- 	end,
	-- },
	{
		"dstein64/nvim-scrollview",
		envet = "VeryLazy",
		config = function()
			require("scrollview").setup({
				-- excluded_filetypes = { "nerdtree" },
			})
		end,
	},

	-- Other useful tool
	{ -- Rainbow delimiters
		"hiphish/rainbow-delimiters.nvim",
		lazy = true,
		event = "BufEnter",
	},
	{
		"RRethy/vim-illuminate",
		event = "BufEnter",
		config = function()
			require("illuminate").configure({
				providers = { "treesitter", "lsp", "regex" },
			})
		end,
	},
	-- { -- Better select with <cr>
	-- 	"gcmt/wildfire.vim",
	-- 	lazy = true,
	-- 	keys = { "<cr>", mode = { "n" }, desc = "Start wildfire" },
	-- },
	{ -- Color indicator
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		cmd = { "ColorizerToggle" },
		config = function()
			require("colorizer").setup({
				filetype = { "css", "html", "javascript" },
				user_default_options = {
					mode = "virtualtext", -- foreground, background,  virtualtext
					virtualtext = "■",
				},
			})
		end,
	},
	{ -- Undotree
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = {
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undotree" },
		},
	},
}
