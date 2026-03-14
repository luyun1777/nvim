vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		local function trigger()
			vim.api.nvim_exec_autocmds("User", { pattern = "LazyLoad" })
		end

		if vim.bo.filetype == "alpha" then
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				once = true,
				callback = trigger,
			})
		else
			trigger()
		end
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { import = "plugins" },
	ui = { border = "rounded" },
	-- git = { timeout = 60, url_format = "https://ghproxy.net//https://github.com/%s.git" },
	-- rocks = { enabled = false },
	-- checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	},
})
