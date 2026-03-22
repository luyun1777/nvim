local M = {}

--- search root directory
---@return string?
function M.get_root()
	local buf = vim.api.nvim_get_current_buf()
	local buf_path = vim.api.nvim_buf_get_name(buf)
	-- 优先从LSP获取根目录
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
		if client.config.root_dir then
			return client.config.root_dir
		end
	end

	-- LSP无结果时，通过文件系统检测项目标记
	local root_marker = {
		".git", -- Git仓库
		".svn", -- SVN 仓库
		".hg", -- Mercurial仓库
		{ "pyproject.toml", "setup.py", "requirements.txt" }, -- Python
		"Cargo.toml", -- Rust项目
		"package.json", -- Node.js项目
		"go.mod", -- Go
		"pom.xml", -- Java (Maven)
		"build.gradle", -- Java (Gradle)
		{ "Makefile", "CMakeLists.txt" }, -- C/C++ (通用)
	}

	local found = vim.fs.root(buf_path or 0, root_marker)
	if found then
		return found
	end

	return vim.uv.cwd()
end

return M
