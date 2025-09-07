local function augroup(name)
	return vim.api.nvim_create_augroup("my_group_" .. name, { clear = true })
end

-- Auto change directory to current dir
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "*", command = "silent! lcd %:p:h" })

-- Auto restore cursor position to last open
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

-- Auto enter insert mode while enter a terminal
vim.cmd([[autocmd TermOpen term://* startinsert]])

-- Auto reload Neovim configuration (partially)
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{ group = augroup("auto_reload"), pattern = { "*.lua", "*.vim", ".vim.lua" }, command = "silent! so %" }
)
-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
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

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"grug-far",
		"lspinfo",
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
		"dbout",
		"gitsigns-blame",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
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
	group = augroup("Lsp"),
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client == nil then
			return
		end

		if client.server_capabilities.completionProvider then
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		end
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		vim.keymap.set("n", "<leader>cl", function()
			vim.lsp.buf.format({ buffer = bufnr, async = true })
		end, { buffer = bufnr, desc = "Format file (Lsp)" })
		vim.keymap.set("n", "<leader>cL", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
		vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
		vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go declaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go definition" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "GO implementation" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go references" })
		vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature help" })
		vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature help" })
		vim.keymap.set(
			"n",
			"<leader>wa",
			vim.lsp.buf.add_workspace_folder,
			{ buffer = bufnr, desc = "Add workspace folder" }
		)
		vim.keymap.set(
			"n",
			"<leader>wr",
			vim.lsp.buf.remove_workspace_folder,
			{ buffer = bufnr, desc = "Remove workspace folder" }
		)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = bufnr, desc = "List workspace folders" })
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type definition" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename variable" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
	end,
})
