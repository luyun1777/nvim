local split = function()
	vim.cmd("set splitbelow")
	vim.cmd("sp")
	vim.cmd("res -5")
end
local compileRun = function()
	vim.cmd("w")
	local ft = vim.bo.filetype
	if ft == "markdown" then
		vim.cmd("MarkdownPreviewToggle")
	elseif ft == "c" then
		split()
		vim.cmd("term gcc % -o %< && ./%< && rm %<")
	elseif ft == "javascript" then
		split()
		vim.cmd("term node %")
	elseif ft == "lua" then
		split()
		vim.cmd("term lua %")
	elseif ft == "tex" then
		vim.cmd("VimtexCompile")
	elseif ft == "python" then
		split()
		vim.cmd('silent! exec "!clear"')
		vim.cmd("term python %")
	end
end

return compileRun
