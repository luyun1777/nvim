local function augroup(name)
	return vim.api.nvim_create_augroup("my_group_" .. name, { clear = true })
end

-- Auto change directory to current dir
-- vim.api.nvim_create_autocmd("BufReadPost", { pattern = "*", command = "silent! lcd %:p:h" })

-- Auto restore cursor position to last open
vim.api.nvim_create_autocmd("BufReadPre", {
	group = augroup("restore_cursor"),
	pattern = "*",
	callback = function()
		vim.api.nvim_create_autocmd("FileType", {
			buffer = 0,
			once = true,
			callback = function()
				local line = vim.fn.line("'\"")
				local last_line = vim.fn.line("$")
				local ft = vim.bo.filetype

				if
					line >= 1
					and line <= last_line
					and not ft:match("commit")
					and not vim.tbl_contains({ "xxd", "gitrebase" }, ft)
					and not vim.opt.diff:get()
				then
					vim.cmd('normal! g`"')
				end
			end,
		})
	end,
})

-- Auto enter insert mode while enter a terminal
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	group = augroup("startinsert"),
	pattern = "term://*",
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.cmd("startinsert")
		end
	end,
})

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
		if vim.fn.has("nvim-0.13") == 1 then
			vim.hl.hl_op()
		else
			(vim.hl or vim.highlight).on_yank()
		end
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
		"checkhealth",
		"dap-float",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
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

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
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

-- Auto create file headers while creating a python file
vim.api.nvim_create_autocmd("BufNewFile", {
	group = augroup("create_python_header"),
	pattern = "*.py",
	callback = require("util.create_header").create_python_header,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp"),
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client == nil then
			return
		end
		if client:supports_method("textDocument/inlayHint", bufnr) then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			vim.keymap.set("n", "<leader>uh", function()
				require("util").toggle.inlay_hints()
			end, { desc = "Toggle Inlay Hints" })
		end
		if client:supports_method("textDocument/codeLens", bufnr) then
			vim.lsp.codelens.enable(true, { bufnr = bufnr })
			vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, { desc = "Run CodeLens" })
			vim.keymap.set("n", "<leader>cC", function()
				require("util").toggle.codelens()
			end, { buffer = bufnr, desc = "Toggle CodeLens" })
		end

		if client.server_capabilities.completionProvider then
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		end
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		vim.keymap.set("n", "<leader>cL", function()
			vim.lsp.buf.format({ buffer = bufnr, async = true })
		end, { buffer = bufnr, desc = "Format file (Lsp)" })
		if vim.fn.has("nvim-0.12") == 1 then
			vim.keymap.set("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", { desc = "Lsp Info" })
		else
			vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
		end
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go declaration" })
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type definition" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go definition" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "GO implementation" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Go references" })
		vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature help" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename variable" })
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
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
	end,
})
