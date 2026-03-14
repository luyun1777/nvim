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
	{
		"lervag/vimtex",
		enabled = vim.fn.executable("tex") == 1,
		lazy = false, -- 确保 VimTeX 在打开 .tex 文件时立即加载
		init = function()
			-- vim.g.vimtex_quickfix_mode = 0 -- set to 0 to never opene quickfix window automatically.
			-- vim.g.vimtex_complete_close_braces = 1 -- whether to append a closing brace after a label or a citation has been completed.
			vim.g.vimtex_compiler_latexmk_engines = { _ = "-xelatex" }
		end,
	},

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
