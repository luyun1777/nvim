return {
	"voldikss/vim-translator",
	cmd = { "Translate" },
	keys = { { "<leader>tr", mode = { "n", "v" } } },
	config = function()
		vim.g.translator_default_engines = { "bing", "haici", "youdao" }
		vim.g.translator_window_borderchars = require("utils.static").borders.rounded
		vim.keymap.set("n", "<leader>tr", "<Plug>TranslateW", { silent = true, desc = "Translate" })
		vim.keymap.set("v", "<leader>tr", "<Plug>TranslateWV", { silent = true, desc = "Translate" })
	end,
}
