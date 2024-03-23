local function augroup(name)
	return vim.api.nvim_create_augroup("my_group_" .. name, { clear = true })
end

-- Auto change directory to current dir
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h" })

-- Auto restore cursor position to last open
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

-- Auto enter insert mode while enter a terminal
vim.cmd([[autocmd TermOpen term://* startinsert]])

-- Auto reload neovim configurations, not works in windows for `source` command is no available
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{ group = augroup("auto_reload"), pattern = "*.vim" or "*.lua" or ".vim.lua", command = "silent! so %" }
)
-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	group = augroup("lsp_diagnostics_hold"),
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float({
			scope = "cursor",
			focusable = false,
			zindex = 10,
			close_events = {
				"CursorMoved",
				"CursorMovedI",
				"BufHidden",
				"InsertCharPre",
				"InsertEnter",
				"WinLeave",
				"ModeChanged",
			},
		})
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.wo.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Auto set tab's length to 2, while open yaml or markdown file
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("yaml_md"),
	pattern = { "*.md", "*.markdown", "*.yaml", "*.yml" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = false
	end,
})

-- 用o换行不要延续注释
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("NoCommentWithO"),
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions
			- "o" -- O and o, don't continue comments
			+ "r" -- But do continue when pressing enter.
	end,
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		vim.keymap.set("n", "<c-s-l>", function()
			vim.lsp.buf.format({ buffer = ev.buf, async = true })
		end, { buffer = ev.buf, desc = "Format file" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go declaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go definition" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "GO implementation" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Go references" })
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf })
		vim.keymap.set(
			"n",
			"<leader>wa",
			vim.lsp.buf.add_workspace_folder,
			{ buffer = ev.buf, desc = "Add workspace folder" }
		)
		vim.keymap.set(
			"n",
			"<leader>wr",
			vim.lsp.buf.remove_workspace_folder,
			{ buffer = ev.buf, desc = "Remove workspace folder" }
		)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = ev.buf, desc = "List workspace folders" })
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Type definition" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename variable" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
	end,
})

-- Auto create head message while create new file
local author, mail = "luyun", "luyun1777@126.com"
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = augroup("auto_create_head_c"),
	pattern = { "*.c", "*.h" },
	callback = function()
		vim.fn.setline(1, "/*************************************************************************")
		vim.fn.setline(2, "    > File Name: " .. vim.fn.expand("%"))
		vim.fn.setline(3, "    > Author: " .. author)
		vim.fn.setline(4, "    > Mail: " .. mail)
		vim.fn.setline(5, "    > Created Time: " .. os.date())
		vim.fn.setline(6, " ************************************************************************/")
		vim.fn.setline(7, "")
		vim.fn.setline(8, "#include <stdio.h>")
		vim.fn.setline(9, "")
		vim.fn.setline(10, "")
	end,
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = augroup("auto_create_head_cpp"),
	pattern = { "*.cpp" },
	callback = function()
		vim.fn.setline(1, "/*************************************************************************")
		vim.fn.setline(2, "    > File Name: " .. vim.fn.expand("%"))
		vim.fn.setline(3, "    > Author: " .. author)
		vim.fn.setline(4, "    > Mail: " .. mail)
		vim.fn.setline(5, "    > Created Time: " .. os.date())
		vim.fn.setline(6, " ************************************************************************/")
		vim.fn.setline(7, "")
		vim.fn.setline(8, "#include <iostream>")
		vim.fn.setline(9, "using namespace std;")
		vim.fn.setline(10, "")
		vim.fn.setline(11, "")
	end,
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = augroup("auto_create_head_java"),
	pattern = { "*.java" },
	callback = function()
		vim.fn.setline(1, "// package")
		vim.fn.setline(2, "/**")
		vim.fn.setline(3, "    @File Name: " .. vim.fn.expand("%"))
		vim.fn.setline(4, "    @Author: " .. author)
		vim.fn.setline(5, "    @Mail: " .. mail)
		vim.fn.setline(6, "    @Created Time : " .. os.date())
		vim.fn.setline(7, "    @Description:")
		vim.fn.setline(8, "*/")
		vim.fn.setline(9, "")
		vim.fn.setline(10, "")
	end,
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = augroup("auto_create_head_sh"),
	pattern = { "*.sh" },
	callback = function()
		vim.fn.setline(1, "#!/usr/bin/sh")
		vim.fn.setline(2, "#########################################################################")
		vim.fn.setline(3, "    File Name: " .. vim.fn.expand("%"))
		vim.fn.setline(4, "    Author: " .. author)
		vim.fn.setline(5, "    Mail: " .. mail)
		vim.fn.setline(6, "    Created Time : " .. os.date())
		vim.fn.setline(7, "    @Description:")
		vim.fn.setline(8, "#########################################################################")
		vim.fn.setline(9, "")
		vim.fn.setline(10, "")
	end,
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = augroup("auto_create_head_python"),
	pattern = { "*.py", "pyc" },
	callback = function()
		vim.fn.setline(1, "# -*- coding:utf8 -*-")
		vim.fn.setline(2, '"""')
		vim.fn.setline(3, "    File Name: " .. vim.fn.expand("%"))
		vim.fn.setline(4, "    Author: " .. author)
		vim.fn.setline(5, "    Mail: " .. mail)
		vim.fn.setline(6, "    Created Time : " .. os.date())
		vim.fn.setline(7, "    @Description:")
		vim.fn.setline(8, '"""')
		vim.fn.setline(9, "")
		vim.fn.setline(10, "def main():")
		vim.fn.setline(11, "    pass")
		vim.fn.setline(12, "")
		vim.fn.setline(13, "if __name__ == '__main__':")
		vim.fn.setline(14, "    main()")
		vim.fn.setline(15, "")
		vim.fn.setline(16, "")
	end,
})
vim.cmd([[autocmd BufNewfile * normal G]])
