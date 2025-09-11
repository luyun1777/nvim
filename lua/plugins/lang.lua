return {
	-- python
	{
		"danymat/neogen",
		cmd = { "Neogen" },
		keys = { { "<leader>cn", "<cmd>Neogen<cr>", desc = "Generate Annotations (Neogen)" } },
		opts = {
			-- snippet_engine = "luasnip",
			languages = {
				lua = { template = { annotation_convention = "emmylua" } }, -- "emmylua", "ldoc"
				python = { template = { annotation_convention = "reST" } }, -- "google_docstrings", "numpydoc", "reST"
				rust = { template = { annotation_convention = "rustdoc" } }, -- "rustdoc", "rust_alternative"
			},
		},
	},

	-- markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		opts = {
			sign = { enabled = false },
			indent = { enabled = true },
		},
	},
	-- {
	-- 	"tadmccorkle/markdown.nvim",
	-- 	ft = { "markdown" },
	-- 	opts = {},
	-- },
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	ft = { "markdown" },
	-- 	keys = { { "<leader>cp", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" } },
	-- 	build = "cd app && npm install",
	-- },

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
	-- 	opts = {},
	-- },

	-- {
	-- 	"sontungexpt/url-open",
	-- 	opts = {},
	-- },
}
