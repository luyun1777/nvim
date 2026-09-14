---@class util.run_file
local M = {}
local split = function()
	vim.cmd("set splitbelow")
	vim.cmd("split")
	vim.cmd("res -5")
end
--- execute single file
M.run = function()
	if vim.bo.modified then
		vim.cmd("write")
	end
	local ft = vim.bo.filetype
	local is_win = vim.uv.os_uname().sysname == "Windows_NT"
	if ft == "c" then
		split()
		if is_win then
			vim.cmd("term gcc % -o %< && ./%< && rm %<" .. ".exe")
		else
			vim.cmd("term gcc % -o %< && ./%< && rm %<")
		end
	elseif ft == "cpp" then
		split()
		if is_win then
			vim.cmd("term g++ % -o %< && ./%< && rm %<" .. ".exe")
		else
			vim.cmd("term g++ % -o %< && ./%< && rm %<")
		end
	elseif ft == "java" then
		split()
		vim.cmd("term java %") -- need java >= 11
		-- vim.cmd("term javac % && java ./% && rm %<" .. ".class")
	elseif ft == "javascript" then
		split()
		vim.cmd("term node %")
	elseif ft == "lua" then
		split()
		vim.cmd("term lua %")
	elseif ft == "tex" then
		if vim.fn.exists(":VimtexCompile") == 2 then
			vim.cmd("VimtexCompile")
		else
			vim.notify("`vimtex` is not installed", vim.log.levels.WARN, { title = "Run Current File" })
		end
	elseif ft == "python" then
		split()
		vim.cmd("term python %")
	elseif ft == "rust" then
		split()
		if is_win then
			vim.cmd("term rustc -C link-arg=/DEBUG:NONE % && ./%< && rm %<" .. ".exe")
		else
			vim.cmd("term rustc % && ./%< && rm %<")
		end
	elseif ft == "sh" then
		split()
		vim.cmd("term bash %")
	else
		vim.notify("Current file type is not supported!", vim.log.levels.WARN, { title = "Run Current File" })
	end
end

return M
