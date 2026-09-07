if vim.loader and vim.fn.has("nvim-0.9") == 1 then
	vim.loader.enable()
end

vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.g.autoformat = true

vim.o.autochdir = true
vim.o.autoindent = true
vim.o.autowrite = true -- Enable auto write
vim.o.backup = false
vim.o.completeopt = "menu,menuone,noselect"
vim.o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
-- vim.o.clipboard = "unnamedplus" -- Sync with system clipboard
vim.o.cursorline = true -- Enable highlighting of the current line
vim.o.diffopt = "closeoff,context:2,filler,followwrap,indent-heuristic,inline:char,internal,linematch:40,vertical"
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.fileformat = "unix"
vim.o.fileformats = "unix,dos,mac"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
vim.opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
vim.o.foldlevel = 99
vim.o.foldmethod = "indent"
vim.o.foldtext = ""
vim.o.formatoptions = "jcroqlnt" -- tcqj
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.o.grepprg = vim.fn.executable("rg") == 1 and "rg --vimgrep --no-heading --smart-case"
vim.o.guicursor =
	"n-v:block-nCursor,i-c-ci-t:ver20-iCursor-blinkwait200-blinkoff200-blinkon200,r-cr-o:hor20-Cursor-blinkwait200-blinkoff200-blinkon200"
vim.o.guifont = "FiraCode Nerd Font Mono:h16,LXGW WenKai Mono:16,Consolas:h16"
vim.o.hlsearch = false
vim.o.ignorecase = true -- Ignore case
vim.o.inccommand = "nosplit" -- preview incremental substitute
vim.o.jumpoptions = "view"
vim.o.laststatus = 3 -- global statusline
vim.o.linebreak = true -- Wrap lines at convenient points
-- vim.o.list = true -- Show some invisible characters (tabs...
-- vim.o.listchars = "space:·,tab:··,trail:▫"
vim.o.mouse = "a" -- Enable mouse mode
vim.o.number = true -- Print line number
vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Maximum number of entries in a popup
vim.o.relativenumber = true -- Relative line numbers
-- vim.o.ruler = false -- Disable the default ruler
vim.o.scrolloff = 4 -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.o.shell = vim.fn.executable("fish") == 1 and "fish" or vim.fn.executable("pwsh") and "pwsh" or nil
if vim.o.shell == "pwsh" then
	vim.o.shellcmdflag =
		"-NoProfile -NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
	vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode' -- Setting shell redirection
	vim.o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode' -- Setting shell pipe
	-- Setting shell quote options
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
end
vim.o.shiftround = true -- Round indent
vim.o.shiftwidth = 4 -- Size of an indent
vim.o.shortmess = "ltToOcCF"
vim.o.showbreak = "↳ " -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
vim.o.showmode = false -- Dont show mode since we have a statusline
vim.o.sidescrolloff = 8 -- Columns of context
vim.o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.smartindent = true -- Insert indents automatically
vim.o.smoothscroll = vim.fn.has("nvim-0.10") == 1 and true or false
vim.o.softtabstop = 4
vim.o.spell = false -- Disable spell
vim.o.splitbelow = true -- Put new windows below current
vim.o.splitkeep = "screen"
vim.o.splitright = true -- Put new windows right of current
vim.o.swapfile = false -- Save swap file and trigger CursorHold
vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.termguicolors = true -- True color support
vim.o.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
-- vim.o.undofile = true
vim.o.updatetime = 200 -- Save swap file and trigger CursorHold
vim.o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.o.wildmode = "longest:full,full" -- Command-line completion mode
vim.o.winborder = "rounded" -- Defines the default border style of floating windows
vim.o.winminwidth = 5 -- Minimum window width
vim.o.writebackup = false
vim.o.wrap = false -- Disable line wrap
