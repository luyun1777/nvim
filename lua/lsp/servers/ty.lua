--- https://github.com/astral-sh/ty
--- https://docs.astral.sh/ty/reference/editor-settings/

---@type vim.lsp.Config
return {
	cmd = { "ty", "server" },

	filetypes = { "python" },
	root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	settings = {
		ty = {
			-- diagnosticMode = "off", -- "off" | "workspace" | "openFilesOnly", Default value: "openFilesOnly"
		},
	},
}
