local split = function()
	vim.cmd("set splitbelow")
	vim.cmd("sp")
	vim.cmd("res -5")
end
local compile_run = function()
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
		vim.cmd("term javac % && java ./% && rm %<" .. ".class")
	elseif ft == "javascript" then
		split()
		vim.cmd("term node %")
	elseif ft == "lua" then
		split()
		vim.cmd("term lua %")
	elseif ft == "tex" then
		if require("lazy.core.config").spec.plugins["vimtex"] ~= nil then
			vim.cmd("VimtexCompile")
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
		vim.notify("Current file type is not supported!", vim.log.levels.WARN, { title = "Compile and Run" })
	end
end

return compile_run
