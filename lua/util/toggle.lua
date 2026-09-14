---@class util.toggle
---@overload fun(): string
local M = setmetatable({}, {
	__call = function(m, ...)
		return m.option(...)
	end,
})

--- Toggle Options
---@param option vim.Option
---@param silent boolean?
---@param values table?
function M.option(option, silent, values)
	if values then
		local current = vim.opt_local[option]:get()
		local new_value = current == values[1] and values[2] or values[1]
		vim.opt_local[option] = new_value
		if not silent then
			vim.notify("Set " .. option .. " to " .. new_value, vim.log.levels.INFO, { title = "Option" })
		end
		return
	end

	local ok, current = pcall(function()
		return vim.opt_local[option]:get()
	end)
	if not ok then
		vim.notify("Failed to get option: " .. tostring(option), vim.log.levels.ERROR, { title = "Option" })
		return
	end

	local new_value = current ~= false
	vim.opt_local[option] = new_value
	if not silent then
		vim.notify(
			(new_value and "Enabled" or "Disabled") .. " " .. tostring(option),
			new_value and vim.log.levels.INFO or vim.log.levels.WARN,
			{ title = "Option" }
		)
	end
end

--- Toggle Line Numbers
function M.number()
	if vim.wo.number or vim.wo.relativenumber then
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.notify("Disabled Line Numbers", vim.log.levels.WARN, { title = "Line Numbers" })
	else
		vim.wo.number = true
		vim.wo.relativenumber = true
		vim.notify("Enabled Line Numbers", vim.log.levels.INFO, { title = "Line Numbers" })
	end
end

--- Toggle Inlay Hints
---@param buf integer?
---@param value boolean?
function M.inlay_hints(buf, value)
	local ih = vim.lsp.inlay_hint or vim.lsp.buf.inlay_hint
	buf = buf or 0
	if type(ih) == "function" then
		ih(buf, value)
	elseif type(ih) == "table" and ih.enable then
		if value == nil then
			value = not ih.is_enabled({ bufnr = buf })
		end
		ih.enable(value, { bufnr = buf })
		vim.notify((value and "Enabled" or "Disabled") .. " Inlay Hint", vim.log.levels.INFO, { title = "Inlay Hints" })
	end
end

--- Toggle CodeLens
---@param buf integer?
---@param value boolean?
function M.codelens(buf, value)
	local cl = vim.lsp.codelens or vim.lsp.buf.codelens
	buf = buf or 0
	if type(cl) == "function" then
		cl(buf, value)
	elseif type(cl) == "table" and cl.enable then
		if value == nil then
			value = not cl.is_enabled({ bufnr = buf })
		end
		cl.enable(value, { bufnr = buf })
		vim.notify((value and "Enabled" or "Disabled") .. " CodeLens", vim.log.levels.INFO, { title = "CodeLens" })
	end
end

return M
