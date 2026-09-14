---@class util
---@field run_file util.run_file
---@field root util.root
---@field toggle util.toggle
local M = {}

setmetatable(M, {
	__index = function(t, k)
		t[k] = require("util." .. k)
		return t[k]
	end,
})
return M
