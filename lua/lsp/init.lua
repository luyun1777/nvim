local icons = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.HINT] = " ",
	[vim.diagnostic.severity.INFO] = " ",
}

---@type vim.diagnostic.Opts.VirtualText
local virtual_text = {
	spacing = 4,
	source = "if_many",
	prefix = function(diagnostic)
		return icons[diagnostic.severity] or "●"
	end,
}

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	float = { source = "if_many" },
	virtual_text = vim.g.enable_virtual_text and virtual_text,
	severity_sort = true,
	signs = { text = icons },
})

vim.keymap.set("n", "<leader>uv", function()
	vim.g.enable_virtual_text = not vim.g.enable_virtual_text
	vim.diagnostic.config({ virtual_text = vim.g.enable_virtual_text and virtual_text })
	vim.notify(
		(vim.g.enable_virtual_text and "Enabled" or "Disabled") .. " `virtual_text`",
		not vim.g.enable_virtual_text and vim.log.levels.WARN or vim.log.levels.INFO,
		{ title = "Virtual Text" }
	)
end, { desc = "Toggle virtual_text (diagnostic)" })

-- capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
-- copy form `https://github.com/saghen/blink.cmp/blob/main/lua/blink/cmp/sources/lib/init.lua`
---@type lsp.ClientCapabilities
local capabilities = {
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true,
				commitCharactersSupport = false, -- TODO:
				documentationFormat = { "markdown", "plaintext" },
				deprecatedSupport = true,
				preselectSupport = false, -- TODO:
				tagSupport = { valueSet = { 1 } }, -- deprecated
				insertReplaceSupport = true, -- TODO:
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
						"command",
						"data",
						-- TODO: support more properties? should test if it improves latency
					},
				},
				insertTextModeSupport = {
					-- TODO: support adjustIndentation
					valueSet = { 1 }, -- asIs
				},
				labelDetailsSupport = true,
			},
			completionList = {
				itemDefaults = {
					"commitCharacters",
					"editRange",
					"insertTextFormat",
					"insertTextMode",
					"data",
				},
			},

			contextSupport = true,
			insertTextMode = 1, -- asIs
		},
	},
}
capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), capabilities)
capabilities = vim.tbl_deep_extend("force", capabilities, {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
})
-- Set default capabilities for all LSP servers
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("clangd", require("lsp.servers.clangd"))
vim.lsp.config("emmylua_ls", require("lsp.servers.emmylua_ls"))
vim.lsp.config("lua_ls", require("lsp.servers.lua_ls"))
vim.lsp.config("rust_analyzer", require("lsp.servers.rust_analyzer"))
vim.lsp.config("ty", require("lsp.servers.ty"))

-- vim.lsp.enable("emmylua_ls")
vim.lsp.enable({ "clangd", "lua_ls", "rust_analyzer", "ty" })

require("lsp.keymaps")
