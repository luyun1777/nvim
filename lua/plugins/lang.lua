return {
	-- python
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = { "Neogen" },
		keys = { { "<leader>cd", "<cmd>Neogen<cr>", desc = "Docstrings" } },
		opts = {
			snippet_engine = "luasnip",
			languages = {
				lua = { template = { annotation_convention = "emmylua" } }, -- "emmylua", "ldoc"
				python = { template = { annotation_convention = "numpydoc" } }, -- "google_docstrings", "numpydoc", "reST"
				rust = { template = { annotation_convention = "rustdoc" } }, -- "rustdoc", "rust_alternative"
			},
		},
	},

	-- markdown
	{
		"tadmccorkle/markdown.nvim",
		ft = { "markdown" },
		opts = {},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		keys = { { "<leader>cp", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" } },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			vim.cmd([[do FileType]])
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
