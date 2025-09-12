local map = vim.keymap.set

map({ "i", "x", "n", "s" }, "<c-s>", "<cmd>w<cr><esc>", { silent = true, desc = "Save file" })
map({ "n", "v" }, "Q", "<cmd>q<cr>", { silent = true, desc = "Quit" })
map({ "n", "v" }, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

map("v", "Y", '"+y', { desc = "Copy to system clipboard" })
map("n", "P", '"+p', { desc = "Paste from system clipboard" })

map("n", "<leader>rc", "<cmd>e $MYVIMRC<cr>,", { silent = true, desc = "Edit configuration" })

-- better indent
map("n", ">", ">>", { silent = true })
map("n", "<", "<<", { silent = true })
map("v", ">", ">gv", { silent = true })
map("v", "<", "<gv", { silent = true })

map("", "x", '"_x', { silent = true })
map("", "X", '"_X', { silent = true })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Add bash shortcuts for command line
map("c", "<c-a>", "<Home>")
map("c", "<c-e>", "<End>")
map("c", "<c-b>", "<Left>")
map("c", "<c-f>", "<Right>")
-- BASH-style movement in insert mode
map("i", "<c-a>", "<c-o>^")
map("i", "<c-e>", "<c-o>$")

-- Move to window using the <ctrl> hjkl keys
map("n", "<c-h>", "<c-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<c-j>", "<c-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<c-k>", "<c-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<c-l>", "<c-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<c-Up>", "<cmd>resize +5<cr>", { desc = "Increase window height" })
map("n", "<c-Down>", "<cmd>resize -5<cr>", { desc = "Decrease window height" })
map("n", "<c-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
map("n", "<c-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<a-j>", "<cmd>m .+1<cr>==", { silent = true, desc = "Move down" })
map("n", "<a-k>", "<cmd>m .-2<cr>==", { silent = true, desc = "Move up" })
map("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi", { silent = true, desc = "Move down" })
map("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi", { silent = true, desc = "Move up" })
map("v", "<a-j>", "<cmd>m '>+1<cr>gv=gv", { silent = true, desc = "Move down" })
map("v", "<a-k>", "<cmd>m '<-2<cr>gv=gv", { silent = true, desc = "Move up" })

-- Buffers management
map("n", "<s-h>", "<cmd>bprevious<cr>", { silent = true, desc = "Prev buffer" })
map("n", "<s-l>", "<cmd>bnext<cr>", { silent = true, desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { silent = true, desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { silent = true, desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { silent = true, desc = "Delete buffer" })
map("n", "<c-tab>", "<cmd>e #<cr>", { silent = true, desc = "Switch to Other Buffer" })

-- windows
map("n", "<leader>ww", "<c-w>p", { desc = "Other Window", remap = true })
map("n", "<leader>wd", "<c-w>c", { desc = "Delete Window", remap = true })
map("n", "<leader>w-", "<c-w>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<c-w>v", { desc = "Split Window Right", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
map("n", "[q", vim.cmd.cprev, { silent = true, desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { silent = true, desc = "Next quickfix" })

-- diagnostic
-- stylua: ignore start
map("n", "<leader>e", vim.diagnostic.setloclist, { desc = "Diagnostic list" })
map("n", "]d", "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<cr>", { desc = "Next Diagnostic" })
map("n", "[d", "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<cr>", { desc = "Next Diagnostic" })
map("n", "]e", "<cmd>lua vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })<cr>", { desc = "Next Error" })
map("n", "[e", "<cmd>lua vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })<cr>", { desc = "Prev Error" })
map("n", "]w", "<cmd>lua vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.WARN })<cr>", { desc = "Next Warning" })
map("n", "[w", "<cmd>lua vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.WARN })<cr>", { desc = "Prev Warning" })

-- Terminal Mappings
map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<c-r>", [['<c-\><c-N>"'.nr2char(getchar()).'pi']], { expr = true })
map("t", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<c-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<c-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<c-q>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- stylua: ignore start
-- toggle options
map("n", "<leader>ub", function() require("util").toggle("background", false, {"light", "dark"}) end, { desc = "Toggle Background" })
map("n", "<leader>ud", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = "Toggle Diagnostics" })

if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
    map( "n", "<leader>uh", function() require("util").toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end

map("n", "<leader>ul", function() require("util").toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>uL", function() require("util").toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>us", function() require("util").toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() require("util").toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>uf", function() vim.g.disable_autoformat = not vim.g.disable_autoformat vim.notify( (vim.g.disable_autoformat and "Disabled " or "Enabled ") .. "Autoformat", vim.log.levels.INFO, { title = "Option" }) end, { desc = "Toggle Autoformat" })
-- stylua: ignore end

-- Useful actions
map("i", "<s-enter>", "<esc>o", { silent = true })

-- Disable `s`、`S`
map("", "s", "<nop>", { silent = true })
map("", "S", "<nop>", { silent = true })

local Util = require("util")
-- stylua: ignore
map("n", "<f5>", function() Util.compile_run() end, { desc = "Run file" })
