local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "LspAttach", "BufFilePost", "DirChanged", "BufEnter" }, {
	group = augroup("root_refresh"),
	callback = function(ev)
		require("util.root").clear_cache(ev.buf)
	end,
})

-- Auto restore cursor position to last location
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(ev)
		local exclude = { "gitcommit", "gitrebase", "help", "dashboard" }
		local buf = ev.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
			return
		end
		vim.b[buf].last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
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
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, ev.buf, { force = true })
			end, {
				buffer = ev.buf,
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
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
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
	pattern = { "markdown", "yaml" },
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.tabstop = 2
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(ev)
		if ev.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(ev.match) or ev.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp"),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client == nil then
			return
		end
		local bufnr = ev.buf
		local has_snacks, _ = pcall(require, "snacks")
		local function map(mode, lhs, rhs, opts)
			vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts or {}, { buffer = bufnr }))
		end

		-- CodeLens
		if client:supports_method("textDocument/codeLens", bufnr) then
			vim.lsp.codelens.enable(true, { bufnr = bufnr })
			map("n", "<leader>cc", vim.lsp.codelens.run, { desc = "Run CodeLens" })
			map("n", "<leader>cC", function()
				require("util.toggle").codelens()
			end, { desc = "Toggle CodeLens" })
		end

		-- Formatting
		map("n", "<leader>cL", function()
			vim.lsp.buf.format({ buffer = bufnr, async = true })
		end, { desc = "Format file (Lsp)" })

		--Folds
		if client:supports_method("textDocument/foldingRange") then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
		end

		-- Inlay Hints
		if client:supports_method("textDocument/inlayHint", bufnr) then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

			if not has_snacks then
				map("n", "<leader>uh", function()
					require("util.toggle").inlay_hints()
				end, { desc = "Toggle Inlay Hints" })
			end
		end

		-- Completion & Tags
		if client.server_capabilities.completionProvider then
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		end
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		if not has_snacks then
			if vim.fn.has("nvim-0.12") == 1 then
				map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", { desc = "Lsp Info" })
			else
				map("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
			end
			map("n", "gD", vim.lsp.buf.declaration, { desc = "Go Declaration" })
			map("n", "gd", vim.lsp.buf.definition, { desc = "Go Definition" })
			map("n", "gi", vim.lsp.buf.implementation, { desc = "Go Implementation" })
			map("n", "gr", vim.lsp.buf.references, { desc = "Go References" })
			map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
		end

		map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
		map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature help" })
		map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
		map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
		map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
		map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
		map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { desc = "List workspace folders" })
	end,
})
