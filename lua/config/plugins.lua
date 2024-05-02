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
-- vim.opt.shadafile = "NONE"
vim.api.nvim_create_autocmd("CmdlineEnter", {
	once = true,
	callback = function()
		local shada = vim.fn.stdpath("state") .. "/shada/main.shada"
		vim.o.shadafile = shada
		vim.api.nvim_command("rshada! " .. shada)
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { import = "plugins" },
	defaluts = { version = false },
	install = { colorscheme = { "gruvbox", "habamax" } },
	ui = { border = "rounded" },
	checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

local Util = require("util")
vim.keymap.set("n", "<f5>", Util.compile_run, { desc = "Run file" })
vim.keymap.set("n", "<leader>st", Util.swap_ternary, { desc = "Swap ternary" })
