local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		-- "https://mirror.ghproxy.com/https://github.com/folke/lazy.nvim.git",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({ import = "plugins" }, { ui = { border = "rounded" } })
-- require("lazy").setup({ import = "plugins" }, { defaults = { version = "*" }, ui = { border = "rounded" } })

local Utils = require("utils")
local opts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end
vim.keymap.set("n", "<f5>", Utils.compile_run, opts("Run file"))
vim.keymap.set("n", "<leader>st", Utils.swap_ternary, opts("Swap ternary"))
