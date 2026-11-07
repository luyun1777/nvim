---@class util.toggle
---@overload fun(option: string, silent?: boolean, values?: table): any
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.option(...)
  end,
})

--- Toggle Options
---@param option string
---@param values table?
---@param silent boolean?
---@return any
function M.option(option, values, silent)
  local ok, current = pcall(function()
    return vim.opt_local[option]:get()
  end)
  if not ok then
    vim.notify('Failed to get option: ' .. tostring(option), vim.log.levels.ERROR, { title = 'Option' })
    return
  end

  local new_value
  if values then
    new_value = current == values[1] and values[2] or values[1]
  else
    if type(current) ~= 'boolean' then
      vim.notify('Option ' .. option .. ' is not boolean, use values', vim.log.levels.ERROR, { title = 'Option' })
      return
    end
    new_value = not current
  end

  local set_ok, err = pcall(function()
    vim.opt_local[option] = new_value
  end)
  if not set_ok then
    vim.notify('Failed to set option: ' .. tostring(err), vim.log.levels.ERROR, { title = 'Option' })
    return
  end

  if not silent then
    if type(new_value) == 'boolean' then
      vim.notify((new_value and 'Enabled' or 'Disabled') .. ' ' .. option, vim.log.levels.INFO, { title = 'Option' })
    else
      vim.notify('Set ' .. option .. ' to ' .. tostring(new_value), vim.log.levels.INFO, { title = 'Option' })
    end
  end
  return new_value
end

--- Toggle Line Numbers
function M.number()
  if vim.wo.number or vim.wo.relativenumber then
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.notify('Disabled Line Numbers', vim.log.levels.INFO, { title = 'Line Numbers' })
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.notify('Enabled Line Numbers', vim.log.levels.INFO, { title = 'Line Numbers' })
  end
end

--- Toggle Inlay Hints
---@param bufnr integer?
---@param value boolean?
function M.inlay_hints(bufnr, value)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if value == nil then
    value = not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  end
  vim.lsp.inlay_hint.enable(value, { bufnr = bufnr })
  vim.notify((value and 'Enabled' or 'Disabled') .. ' Inlay Hint', vim.log.levels.INFO, { title = 'Inlay Hints' })
end

--- Toggle CodeLens
---@param bufnr integer?
---@param value boolean?
function M.codelens(bufnr, value)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if value == nil then
    value = not vim.lsp.codelens.is_enabled({ bufnr = bufnr })
  end
  vim.lsp.codelens.enable(value, { bufnr = bufnr })
  vim.notify((value and 'Enabled' or 'Disabled') .. ' CodeLens', vim.log.levels.INFO, { title = 'CodeLens' })
end

return M
