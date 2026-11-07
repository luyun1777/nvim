if vim.loader and vim.fn.has('nvim-0.9') == 1 then
  vim.loader.enable()
end

vim.g.mapleader = ' '
vim.g.localleader = '\\'

vim.g.autoformat = true

vim.g.enable_virtual_text = false -- whether enable `virtual_text` (vim.diagnostic.config)

-- Set LSP servers to be ignored when used with `util.root.get_lsp_root` for detecting the LSP root
vim.g.root_lsp_ignore = {}

local o = vim.o

o.autochdir = true
o.autowrite = true -- Enable auto write
o.breakindent = true -- Indent wrapped lines to match line start
o.completeopt = 'menu,menuone,noselect'
o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
o.confirm = true -- Confirm to save changes before exiting modified buffer
-- o.clipboard = 'unnamedplus' -- Sync with system clipboard
o.cursorline = true -- Enable highlighting of the current line
o.diffopt = 'internal,filler,closeoff,indent-heuristic,inline:char,linematch:40,context:2,followwrap,vertical'
o.expandtab = true -- Use spaces instead of tabs
o.fileformat = 'unix'
o.fileformats = 'unix,dos,mac'
o.fillchars = 'foldopen:,foldclose:,fold: ,foldsep: ,diff:╱,eob: '
o.foldlevel = 99
o.foldmethod = 'indent'
o.foldtext = ''
o.formatoptions = 'jcroqlnt' -- tcqj
o.grepformat = '%f:%l:%c:%m'
o.guicursor =
  'n-v:block-nCursor,i-c-ci-t:ver20-iCursor-blinkwait200-blinkoff200-blinkon200,r-cr-o:hor20-Cursor-blinkwait200-blinkoff200-blinkon200'
o.guifont = 'FiraCode Nerd Font Mono,LXGW WenKai Mono:h16'
o.hlsearch = false
o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
o.inccommand = 'nosplit' -- preview incremental substitute
o.jumpoptions = 'view'
o.laststatus = 3 -- global statusline
o.linebreak = true -- Wrap lines at convenient points
-- o.list = true -- Show some invisible characters (tabs...
-- o.listchars = 'extends:…,nbsp:␣,precedes:…,space:·,tab:··,trail:▫' -- Define which helper symbols to show
o.mouse = 'a' -- Enable mouse mode
o.number = true -- Print line number
o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup
o.relativenumber = true -- Relative line numbers
o.ruler = false -- Disable the default ruler
o.scrolloff = 4 -- Lines of context
-- o.sessionoptions = 'buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds'
o.shiftround = true -- Round indent
o.shiftwidth = 4 -- Size of an indent
o.shortmess = 'ltToOcCF' -- 'ltToOCF'
o.showbreak = '↳ ' -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
o.showmode = false -- Dont show mode since we have a statusline
o.sidescrolloff = 8 -- Columns of context
o.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
o.smartcase = true -- Don't ignore case with capitals
o.smartindent = true -- Insert indents automatically
o.smoothscroll = true
o.softtabstop = 4
o.splitbelow = true -- Put new windows below current
o.splitkeep = 'screen'
o.splitright = true -- Put new windows right of current
o.swapfile = false -- Disuse a swapfile for the buffer
o.tabstop = 4 -- Number of spaces tabs count for
o.termguicolors = true -- True color support
o.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
o.updatetime = 200 -- Save swap file and trigger CursorHold
o.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
o.wildmode = 'longest:full,full' -- Command-line completion mode
o.winblend = 10 -- Make floating windows slightly transparent
o.winborder = 'rounded' -- Defines the default border style of floating windows
o.winminwidth = 5 -- Minimum window width
o.wrap = false -- Disable line wrap

if vim.fn.executable('fish') == 1 then
  o.shell = 'fish'
elseif vim.fn.executable('pwsh') == 1 and vim.uv.os_uname().sysname == 'Windows_NT' then
  o.shell = 'pwsh'
  o.shellcmdflag =
    "-NoProfile -NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
  o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  o.shellquote = ''
  o.shellxquote = ''
end
