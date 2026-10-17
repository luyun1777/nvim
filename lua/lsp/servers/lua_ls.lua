--- See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the above fields:
--- * [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
--- * [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)

local root_markers1 = {
	".emmyrc.json",
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
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers1, root_markers2, { ".git" } }
		or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { ".git" }),
	---@type lspconfig.settings.lua_ls
	settings = {
		Lua = {
			codeLens = { enable = true },
			hint = { enable = true, semicolon = "Disable" },
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?/init.lua",
					"lua/?.lua",
					"?/lua/?/init.lua",
					"?/lua/?.lua",
				},
			},
			diagnostics = {
				globals = { "vim", "require" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
					-- vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
					-- "${3rd}/luv/library",
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
