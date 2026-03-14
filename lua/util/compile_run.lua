local split = function()
	vim.cmd("set splitbelow")
	vim.cmd("sp")
	vim.cmd("res -5")
end
local compileRun = function()
	if vim.bo.modified then
		vim.cmd("write")
	end
	local ft = vim.bo.filetype
	if ft == "c" then
		split()
		vim.cmd("term gcc % -o %< && ./%< && rm %<")
	elseif ft == "cpp" then
		split()
		vim.cmd("term g++ % -o %< && ./%< && rm %<")
	elseif ft == "java" then
		split()
		local filename = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
		local classfile = vim.fn.fnamemodify(filename, ":t:r") .. ".class"
		vim.cmd("term javac % && java ./% && rm " .. classfile)
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
		vim.cmd("term rustc % && ./%< && rm %<")
	elseif ft == "sh" then
		split()
		vim.cmd("term bash %")
	end
end

return compileRun
