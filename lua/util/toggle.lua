local M = {}

--- Toggle options
---@param option vim.Option
---@param silent boolean?
---@param values table?
function M.option(option, silent, values)
	if values then
		if vim.opt_local[option]:get() == values[1] then
			vim.opt_local[option] = values[2]
		else
			vim.opt_local[option] = values[1]
		end
		return vim.notify(
			"Set " .. option .. " to " .. vim.opt_local[option]:get(),
			vim.log.levels.INFO,
			{ title = "Option" }
		)
	end
	vim.opt_local[option] = not vim.opt_local[option]:get()
	if not silent then
		if vim.opt_local[option]:get() then
			vim.notify("Enabled " .. option, vim.log.levels.INFO, { title = "Option" })
		else
			vim.notify("Disabled " .. option, vim.log.levels.WARN, { title = "Option" })
		end
	end
end

--- Toggle line numbers
function M.number()
	if vim.wo.number or vim.wo.relativenumber then
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.notify("Disabled line numbers", vim.log.levels.WARN, { title = "Option" })
	else
		vim.wo.number = true
		vim.wo.relativenumber = true
		vim.notify("Enabled line numbers", vim.log.levels.INFO, { title = "Option" })
	end
end

--- Toggle inlay_hints
---@param buf integer?
---@param value boolean?
function M.inlay_hints(buf, value)
	local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
	if type(ih) == "function" then
		ih(buf, value)
	elseif type(ih) == "table" and ih.enable then
		if value == nil then
			value = not ih.is_enabled(buf)
		end
		ih.enable(value, { bufnr = buf })
		vim.notify((value and "Enabled" or "Disabled") .. " inlay_hint", vim.log.levels.INFO, { title = "Option" })
	end
end

setmetatable(M, {
	__call = function(m, ...)
		return m.option(...)
	end,
})

return M
