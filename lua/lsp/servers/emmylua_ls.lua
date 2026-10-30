---
--- https://github.com/EmmyLuaLs/emmylua-analyzer-rust
---
--- See the emmylua_ls [configuration guide](https://github.com/EmmyLuaLs/emmylua-analyzer-rust/blob/main/docs/config/emmyrc_json_EN.md) for settings documentation.
---

local root_markers1 = {
	".emmyrc.json",
	".emmyrc.lua",
	".luarc.json",
	".luarc.jsonc",
}
local root_markers2 = {
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
}

---@type vim.lsp.Config
return {
	cmd = { "emmylua_ls" },
	filetypes = { "lua" },
	root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers1, root_markers2, { ".git" } }
		or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { ".git" }),
	workspace_required = false,
	---@type lspconfig.settings.emmylua_ls
	settings = {
		emmylua = {
			codeLens = { enable = true, enumParamHint = true },
			diagnostics = { globals = { "vim", "require" } },
			hint = { enable = true },
		},
	},
}
