return {
	-- python
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = { "Neogen" },
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip",
				languages = {
					python = {
						template = { annotation_convention = "reST" }, -- "google_docstrings", "numpydoc", "reST"
					},
				},
			})
		end,
	},
	{
		"nmac427/guess-indent.nvim",
		event = "VeryLazy",
		config = function()
			require("guess-indent").setup({})
		end,
	},

	-- html
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "html", "javascript", "markdown", "php", "xml" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- markdown
	{
		"tadmccorkle/markdown.nvim",
		ft = { "markdown" }, -- or 'event = "VeryLazy"'
		opts = {
			-- configuration here or empty for defaults
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = (function()
			if vim.fn.executable("yarn") == 1 then
				return "cd app && yarn install"
			end
			if vim.fn.executable("npm") == 1 then
				return "cd app && npm install"
			end
			return function()
				vim.fn["mkdp#util#install"]()
			end
		end)(),
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		keys = {
			{
				"<leader>mp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		config = function()
			vim.cmd([[do FileType]])
			require("markdown").setup({})
		end,
	},

	-- Tex
	-- {
	-- 	"lervag/vimtex",
	-- 	ft = { "tex", "latex" },
	-- 	init = function()
	-- 		-- Use init for configuration, don't use the more common "config".
	-- 	end,
	-- },
	-- {
	-- 	"Eandrju/cellular-automaton.nvim",
	-- 	keys = {
	-- 		{
	-- 			"<leader>qq",
	-- 			"<cmd>CellularAutomaton make_it_rain<CR>",
	-- 			desc = "Fun",
	-- 		},
	-- 	},
	-- 	config = function() end,
	-- },

	-- {
	-- 	"sontungexpt/url-open",
	-- 	config = function()
	-- 		require("url-open").setup({})
	-- 	end,
	-- },
}
