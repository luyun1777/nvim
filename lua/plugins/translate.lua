return {
	"voldikss/vim-translator",
	config = function()
		-- vim.cmd("let g:translator_default_engines = ['bing', 'haici', 'youdao']")
		-- vim.cmd("let g:translator_window_borderchars= ['─', '│', '─', '│', '╭', '╮', '╯', '╰']")
		-- vim.keymap.set("n", "<leader>t", "<Plug>TranslateW", { silent = true, desc = "Translate" })
		vim.g.translator_default_engines = { "bing", "haici", "youdao" }
		vim.g.translator_window_borderchars = require("utils.static").borders.rounded
		vim.keymap.set("n", "<leader>tr", "<cmd>TranslateW<cr>", { silent = true, desc = "Translate" })
	end,
}
