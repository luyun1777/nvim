---@class util
---@field root util.root
---@field run util.run
---@field toggle util.toggle
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require('util.' .. k)
    return t[k]
  end,
})
return M
