local M = {}

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
	-- 定义默认的标记文件列表，通常 vim.fs.find 会返回最近的一个
	local root_files = {
		".git", -- Git仓库
		".svn", -- SVN 仓库
		".hg", -- Mercurial仓库
		"package.json", -- Node.js项目
		"Cargo.toml", -- Rust项目
		"pyproject.toml", -- Python项目
		"setup.py", -- Python (传统)
		"requirements.txt", -- Python
		"go.mod", -- Go
		"pom.xml", -- Java (Maven)
		"build.gradle", -- Java (Gradle)
		"Makefile", -- C/C++/通用
		"CMakeLists.txt", -- C/C++ (CMake)
	}

	local found = vim.fs.find(root_files, {
		upward = true, -- 向上搜索
		path = vim.fs.dirname(buf_path),
		-- type = "directory", -- 优先目录类型
	})

	if found and #found > 0 then
		local found_path = found[1]
		if vim.fn.isdirectory(found_path) == 1 then
			return vim.fs.dirname(found_path)
		else
			return vim.fn.fnamemodify(found_path, ":h")
		end
	end

	return vim.fn.getcwd()
end

return M
