local M = {}

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

local nu = { number = true, relativenumber = true }
function M.number()
	if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
		nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.notify("Disabled line numbers", vim.log.levels.WARN, { title = "Option" })
	else
		vim.opt_local.number = nu.number
		vim.opt_local.relativenumber = nu.relativenumber
		vim.notify("Enabled line numbers", vim.log.levels.INFO, { title = "Option" })
	end
end

local enabled = true
function M.diagnostics()
	-- if this Neovim version supports checking if diagnostics are enabled
	-- then use that for the current state
	if vim.diagnostic.is_disabled then
		enabled = not vim.diagnostic.is_disabled()
	end
	enabled = not enabled

	if enabled then
		vim.diagnostic.enable()
		vim.notify("Enabled diagnostics", vim.log.levels.INFO, { title = "Diagnostics" })
	else
		vim.diagnostic.disable()
		vim.notify("Disabled diagnostics", vim.log.levels.WARN, { title = "Diagnostics" })
	end
end

function M.inlay_hints(buf, value)
	local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
	if type(ih) == "function" then
		ih(buf, value)
	elseif type(ih) == "table" and ih.enable then
		if value == nil then
			value = not ih.is_enabled(buf)
		end
		ih.enable(value, { bufnr = buf })
	end
end

setmetatable(M, {
	__call = function(m, ...)
		return m.option(...)
	end,
})

return M
