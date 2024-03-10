return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		cmd = "WhichKey",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			local wk = require("which-key")
			wk.register({
				["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
				["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
				["<leader>l"] = { name = "Lsp find", _ = "which_key_ignore" },
			})
		end,
	},
}
