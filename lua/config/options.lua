if vim.loader and vim.fn.has("nvim-0.9") == 1 then
	vim.loader.enable()
end

vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.g.autoformat = true -- Used by `confirm.nvim`

-- Set LSP servers to be ignored when used with `util.root.get_lsp_root`
-- for detecting the LSP root
vim.g.root_lsp_ignore = {}

local opt = vim.opt

opt.autochdir = true
opt.autoindent = true
opt.autowrite = true -- Enable auto write
opt.backup = false
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.cursorline = true -- Enable highlighting of the current line
-- opt.diffopt = "closeoff,context:2,filler,followwrap,indent-heuristic,inline:char,internal,linematch:40,vertical"
-- internal,filler,closeoff,indent-heuristic,inline:char,linematch:40
opt.diffopt:append({ "context:2", "followwrap", "vertical" })
opt.expandtab = true -- Use spaces instead of tabs
opt.fileformat = "unix"
opt.fileformats = "unix,dos,mac"
opt.fileencoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldtext = ""
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.guicursor =
	"n-v:block-nCursor,i-c-ci-t:ver20-iCursor-blinkwait200-blinkoff200-blinkon200,r-cr-o:hor20-Cursor-blinkwait200-blinkoff200-blinkon200"
opt.guifont = "FiraCode Nerd Font Mono,LXGW WenKai Mono,Consolas"
opt.hlsearch = false
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
-- opt.list = true -- Show some invisible characters (tabs...
-- opt.listchars = "space:·,tab:··,trail:▫"
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
-- opt.ruler = false -- Disable the default ruler
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.shortmess:append({ c = true, C = true }) -- "ltToOCF"
opt.showbreak = "↳ " -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.smoothscroll = vim.fn.has("nvim-0.10") == 1
opt.softtabstop = 4
opt.spell = false -- Disable spell
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.swapfile = false -- Save swap file and trigger CursorHold
opt.tabstop = 4 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
-- opt.undofile = true
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winborder = "rounded" -- Defines the default border style of floating windows
opt.winminwidth = 5 -- Minimum window width
opt.writebackup = false
opt.wrap = false -- Disable line wrap

if vim.fn.executable("rg") == 1 then
	opt.grepprg = "rg --vimgrep --smart-case"
end

if vim.fn.executable("fish") == 1 then
	opt.shell = "fish"
elseif vim.fn.executable("pwsh") == 1 then
	opt.shell = "pwsh"
	opt.shellcmdflag =
		"-NoProfile -NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
	opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
	opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
	opt.shellquote = ""
	opt.shellxquote = ""
end
