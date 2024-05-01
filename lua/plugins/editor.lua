return {
	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		cmd = { "NvimTreeToggle" },
		keys = { { "tt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" } },
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
		event = "VeryLazy",
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
		dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		opts = {
			provider_selector = function(_, filetype, buftype)
				return (filetype == "" or buftype == "nofile") and "indent" or { "treesitter", "indent" }
			end,
		},
	},

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
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
							vim.notify(tostring(err), vim.log.levels.ERROR)
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
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		version = "*",
		opts = {},
	},
	{
		"dstein64/nvim-scrollview",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
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
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = function()
			require("illuminate").configure({
				delay = 200,
				large_file_cutoff = 2000,
				providers = { "treesitter", "lsp", "regex" },
			})
		end,
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
		dependencies = "nvim-lua/plenary.nvim",
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
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gs"] = { name = "+surround" },
				["z"] = { name = "+fold" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>t"] = { name = "+terminal/translate" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
}
