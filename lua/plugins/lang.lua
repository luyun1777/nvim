return {
	-- Annotations
	{
		"danymat/neogen",
		cmd = { "Neogen" },
		keys = {
			{
				"<leader>cn",
				function()
					require("neogen").generate()
				end,
				desc = "Generate Annotations (Neogen)",
			},
		},
		opts = {
			snippet_engine = "nvim",
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
		keys = {
			{
				"<leader>um",
				function()
					require("render-markdown").toggle()
				end,
				desc = "Toggle Render Markdown",
			},
		},
		opts = {
			sign = { enabled = false },
			indent = { enabled = true },
		},
	},
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
		lazy = false,
		keys = {
			{ "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
		},

		config = function()
			vim.g.vimtex_quickfix_mode = 0 -- set to 0 to never open quickfix window automatically.
			vim.g.vimtex_compiler_latexmk_engines = { _ = "-xelatex" }
		end,
	},
}
