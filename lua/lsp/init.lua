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

local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
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
