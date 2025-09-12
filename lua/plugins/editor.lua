return {
	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle" },
		keys = { { "tt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" } },
		opts = {
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = { enable = true, update_root = true },
			view = { width = 20 },
			renderer = { group_empty = true, indent_markers = { enable = true } },
			filters = { dotfiles = true, git_ignored = true },
		},
	},
	{
		"mikavilpas/yazi.nvim",
		enabled = vim.fn.executable("yazi") == 1,
		cmd = "Yazi",
		keys = {
			{
				"<leader>-",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
		},
		opts = {
			open_for_directories = false,
		},
	},

	-- Better move
	{
		"folke/flash.nvim",
		opts = { rainbow = { enable = true } },
		-- stylua: ignore
		keys = {
			{ "s", function() require("flash").jump() end, desc = "Flash" },
			{ "S", function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		},
	},
	-- Better fold
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "VeryLazy",
		opts = {
			provider_selector = function(_, filetype, buftype)
				return (filetype == "" or buftype == "nofile") and "indent" or { "treesitter", "indent" }
			end,
		},
	},

	-- Better surrounding
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},
	{
		"dstein64/nvim-scrollview",
		event = "VeryLazy",
		opts = {},
	},

	-- Other useful tool
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	-- search/replace in multiple files
	{
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
	},

	{ -- Rainbow delimiters
		"hiphish/rainbow-delimiters.nvim",
		event = "VeryLazy",
	},
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
	},
	{ -- Color indicator
		"NvChad/nvim-colorizer.lua",
		cmd = { "ColorizerToggle" },
		keys = { { "<leader>uC", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" } },
		opts = {
			user_default_options = {
				mode = "virtualtext", -- foreground, background,  virtualtext
				virtualtext = "■",
			},
		},
	},
	-- { -- Undotree
	-- 	"jiaoshijie/undotree",
	-- 	opts = {},
	-- 	keys = {
	-- 		{ "<leader>U", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undotree" },
	-- 	},
	-- },
	{ -- Translate
		"voldikss/vim-translator",
		cmd = { "Translate" },
		keys = {
			{ "<leader>tr", "<Plug>TranslateW", desc = "Translate" },
			{ "<leader>tr", "<Plug>TranslateWV", mode = "v", desc = "Translate" },
		},
		init = function()
			vim.g.translator_default_engines = { "bing", "haici", "youdao" }
			vim.g.translator_window_borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		opts = {
			preset = "helix",
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>b", group = "buffer" },
					{ "<leader>c", group = "code" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>s", group = "search" },
					{ "<leader>t", group = "terminal/translate" },
					{ "<leader>u", group = "ui" },
					{ "<leader>w", group = "windows" },
					{ "<leader>x", group = "diagnostics/quickfix" },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "z", group = "fold" },
				},
			},
		},
	},
}
