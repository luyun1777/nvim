-- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_keymaps_bind", { clear = true }),
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
