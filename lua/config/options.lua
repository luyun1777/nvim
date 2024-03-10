-- refernce  https://blog.csdn.net/lxyoucan/article/details/120300779

if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
	vim.loader.enable()
end

vim.g.fileformats = "unix,dos,mac"
vim.g.encoding = "UTF-8"
vim.g.iskeyword = vim.o.iskeyword .. "_,$,@,%,#,-"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
vim.o.guicursor =
	"n:block-blinkwait0,i-ci:ver20-iCursor-blinkwait300-blinkon250-blinkoff200,c-r-cr-o:hor10-block-blinkwait300-blinkon250-blinkoff200"
-- vim.o.guifont = "FiraCode Nerd Font Mono:h18:qDRAFT"
vim.o.guifont = "FiraCode Nerd Font Mono:h16:qDRAFT,JetBrainsMono Nerd Font Mono:h16:b:cANSI:qDRAFT,Consolas:h16"

vim.cmd([[set diffopt+=context:3,vertical,followwrap]]) -- better diff
vim.o.smoothscroll = true
-- vim.o.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
-- vim.o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.o.winminwidth = 5 -- Minimum window width
vim.o.autowrite = true -- Enable auto write
-- vim.o.clipboard = "unnamedplus" -- Sync with system clipboard
vim.o.conceallevel = 3 -- Hide * markup for bold and italic
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.cursorline = true -- Enable highlighting of the current line
vim.o.termguicolors = true -- True color support
vim.o.spell = false -- Disalbe spell
vim.o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.ttyfast = true
vim.o.autochdir = true
vim.o.exrc = true
vim.o.secure = false
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
vim.o.listchars = "space:·,tab:>-,trail:▫"
vim.o.scrolloff = 4 -- Lines of context
vim.o.sidescrolloff = 8 -- Columns of context
vim.o.ttimeoutlen = 300
vim.o.timeout = true
vim.o.viewoptions = "cursor,folds,slash,unix"
vim.o.wrap = true -- enable line wrap
vim.o.textwidth = 0
vim.o.indentexpr = ""
vim.o.foldcolumn = "1"
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.foldenable = true
vim.o.foldlevelstart = 99
-- vim.o.formatoptions = vim.o.formatoptions:gsub("tc", "")
vim.o.formatoptions = "jcroqlnt" -- tcqj
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep"
vim.o.splitright = true -- Put new windows right of current
vim.o.splitbelow = true -- Put new windows below current
vim.o.showmode = false -- Don't show the mode, since it's already in status line
vim.o.shortmess = vim.o.shortmess .. "cCI"
vim.o.inccommand = "split" -- preview incremental substitute
-- vim.o.completeopt = "longest,noinsert,menuone,noselect,preview"
vim.o.completeopt = "menu,menuone,noselect"
-- vim.o.completeopt = 'menuone,noinsert,noselect,preview'
-- vim.o.lazyredraw = true
vim.o.visualbell = false
vim.o.errorbells = false
vim.o.colorcolumn = "200"
vim.o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.cmdheight = 1
vim.o.autoread = true
vim.bo.autoread = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false -- Save swap file and trigger CursorHold
vim.o.hidden = true
vim.o.mouse = "a" -- Enable mouse mode
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full" -- Command-line completion mode
vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Maximum number of entries in a popup
vim.o.showmode = false -- Dont show mode since we have a statusline
vim.o.ruler = true
vim.o.ruler = "%15(%c%V %p%%%)"
vim.o.laststatus = 2
vim.diagnostic.config({
	severity_sort = true,
	underline = true,
	signs = true,
	virtual_text = false,
	update_in_insert = false,
	float = true,
})

vim.g.terminal_color_0 = "#000000"
vim.g.terminal_color_1 = "#FF5555"
vim.g.terminal_color_2 = "#50FA7B"
vim.g.terminal_color_3 = "#F1FA8C"
vim.g.terminal_color_4 = "#BD93F9"
vim.g.terminal_color_5 = "#FF79C6"
vim.g.terminal_color_6 = "#8BE9FD"
vim.g.terminal_color_7 = "#BFBFBF"
vim.g.terminal_color_8 = "#4D4D4D"
vim.g.terminal_color_9 = "#FF6E67"
vim.g.terminal_color_10 = "#5AF78E"
vim.g.terminal_color_11 = "#F4F99D"
vim.g.terminal_color_12 = "#CAA9FA"
vim.g.terminal_color_13 = "#FF92D0"
vim.g.terminal_color_14 = "#9AEDFE"
