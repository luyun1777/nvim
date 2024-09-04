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
		"theniceboy/joshuto.nvim",
		enabled = vim.fn.executable("joshuto") == 1,
		keys = { { "<leader>ra", "<cmd>Joshuto<cr>", desc = "Start joshuto" } },
		cmd = "Joshuto",
		init = function()
			vim.g.joshuto_floating_window_scaling_factor = 1.0
			vim.g.joshuto_use_neovim_remote = 1
			vim.g.joshuto_floating_window_winblend = 0
		end,
	},

	-- Better move
	{
		"folke/flash.nvim",
		event = "User LazyLoad",
		opts = { rainbow = { enable = true } },
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		},
	},
	-- Better fold
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "User LazyLoad",
		opts = {
			provider_selector = function(_, filetype, buftype)
				return (filetype == "" or buftype == "nofile") and "indent" or { "treesitter", "indent" }
			end,
		},
	},

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Diagnostics (Trouble)" },
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=true<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>cS",
				"<cmd>Trouble lsp toggle focus=true<cr>",
				desc = "LSP references/definitions/... (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle focus=true<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle focus=true<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},
	-- Better surrounding
	{
		"kylechui/nvim-surround",
		event = "User LazyLoad",
		opts = {},
	},
	{
		"dstein64/nvim-scrollview",
		event = "User LazyLoad",
		opts = {},
	},

	-- Other useful tool
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{ -- Rainbow delimiters
		"hiphish/rainbow-delimiters.nvim",
		event = "User LazyLoad",
	},
	{
		"RRethy/vim-illuminate",
		event = "User LazyLoad",
	},
	{ -- Color indicator
		"NvChad/nvim-colorizer.lua",
		cmd = { "ColorizerToggle" },
		keys = { { "<leader>uc", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" } },
		opts = {
			user_default_options = {
				mode = "virtualtext", -- foreground, background,  virtualtext
				virtualtext = "■",
			},
		},
	},
	{ -- Undotree
		"jiaoshijie/undotree",
		opts = {},
		keys = {
			{ "<leader>U", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undotree" },
		},
	},
	{ -- Translate
		"voldikss/vim-translator",
		cmd = { "Translate" },
		keys = {
			{ "<leader>tr", "<Plug>TranslateW", desc = "Translate" },
			{ "<leader>tr", "<Plug>TranslateWV", mode = "v", desc = "Translate" },
		},
		init = function()
			vim.g.translator_default_engines = { "bing", "haici", "youdao" }
			vim.g.translator_window_borderchars = require("util.static").borders.rounded
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
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>b", group = "buffer" },
					{ "<leader>c", group = "code" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>q", group = "quit/session" },
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
