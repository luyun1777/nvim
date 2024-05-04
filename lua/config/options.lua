if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
	vim.loader.enable()
end

vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.o.fileformats = "unix,dos,mac"
vim.o.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
vim.o.fileencoding = "utf-8"
vim.o.guicursor =
	"n:block-blinkwait0,i-ci:ver20-iCursor-blinkwait300-blinkon250-blinkoff200,c-r-cr-o:hor10-block-blinkwait300-blinkon250-blinkoff200"
vim.o.guifont = "FiraCode Nerd Font Mono:h16:qDRAFT,JetBrainsMono Nerd Font Mono:h16:b:cANSI:qDRAFT,Consolas:h16"

vim.cmd([[set diffopt+=context:3,vertical,followwrap]]) -- better diff

vim.o.winminwidth = 5 -- Minimum window width
vim.o.autowrite = true -- Enable auto write
-- vim.o.clipboard = "unnamedplus" -- Sync with system clipboard
vim.o.conceallevel = 2 -- Hide * markup for bold and italic
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.cursorline = true -- Enable highlighting of the current line
vim.o.termguicolors = true -- True color support
vim.o.spell = false -- Disalbe spell
vim.o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.autochdir = true
vim.o.number = true -- Print line number
vim.o.relativenumber = true -- Relative line numbers
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.smartindent = true -- Insert indents automatically
vim.o.shiftwidth = 4 -- Size of an indent
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftround = true -- Round indent
vim.o.list = false -- Show some invisible characters (tabs...
vim.o.listchars = "space:·,tab:··,trail:▫"
vim.o.scrolloff = 4 -- Lines of context
vim.o.sidescrolloff = 8 -- Columns of context
vim.o.timeoutlen = 300
vim.o.timeout = true
vim.o.viewoptions = "cursor,folds,slash,unix"
vim.o.wrap = true -- enable line wrap
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
if vim.fn.executable("rg") == 1 then
	vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
	vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
vim.o.splitright = true -- Put new windows right of current
vim.o.showbreak = "↳ " -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
vim.o.splitbelow = true -- Put new windows below current
vim.o.showmode = false -- Don't show the mode, since it's already in status line
vim.o.shortmess = vim.o.shortmess .. "cCI"
vim.o.inccommand = "split" -- preview incremental substitute
vim.o.completeopt = "menu,menuone,noselect"
vim.o.colorcolumn = "200"
vim.o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.autoread = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false -- Save swap file and trigger CursorHold
vim.o.mouse = "a" -- Enable mouse mode
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full" -- Command-line completion mode
vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Maximum number of entries in a popup
vim.o.showmode = false -- Dont show mode since we have a statusline
if vim.fn.has("nvim-0.10") == 1 then
	vim.o.smoothscroll = true
end
