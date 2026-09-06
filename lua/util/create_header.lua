local M = {}
M.create_python_header = function()
	local author = "luyun"
	local time = os.date("%Y/%m/%d %H:%M")
	local header = {
		"#!/usr/bin/env python3",
		"",
		"# @author:  " .. author,
		"# @time:  " .. time,
		"",
	}

	vim.api.nvim_buf_set_lines(0, 0, 0, true, header)
	vim.api.nvim_win_set_cursor(0, { #header + 1, 0 })
end

return M
