vim.g.mapleader = " "
vim.g.localleader = "\\"
local map = vim.keymap.set

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { noremap = true, silent = true, desc = "Save file" })
map("n", "S", "<cmd>w<cr>", { noremap = true, silent = true, desc = "Save file" })
map({ "n", "v" }, "Q", "<cmd>q<cr>", { noremap = true, silent = true, desc = "Quit" })
map({ "n", "v" }, ";", ":", { noremap = true, silent = false })
map({ "n", "v" }, ":", ";", { noremap = true, silent = false })
map("v", "Y", '"+y', { desc = "Copy to system clipboard" })
map("n", "P", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "v" }, "`", "~", { noremap = true, silent = false })
map({ "n", "v" }, "~", "`", { noremap = true, silent = false })
map("n", "<leader>rc", "<cmd>e $MYVIMRC<cr>,", { noremap = true, silent = true, desc = "Edit configuration" })
map("n", ">", ">>", { noremap = true, silent = true })
map("n", "<", "<<", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })
map("v", "<", "<gv", { noremap = true, silent = true })
map("", "x", '"_x', { noremap = true, silent = true })
map("", "X", '"_X', { noremap = true, silent = true })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Add bash shortcuts for command line
map("c", "<C-a>", "<Home>")
map("c", "<C-b>", "<Left>")
-- BASH-style movement in insert mode
map("i", "<C-a>", "<C-o>^")
map("i", "<C-e>", "<C-o>$")

-- Move to window using the <leader> hjkl keys
map("n", "<leader>h", "<c-w>h", { noremap = true, silent = true, desc = "Go to left window" })
map("n", "<leader>j", "<c-w>j", { noremap = true, silent = true, desc = "Go to lower window" })
map("n", "<leader>k", "<c-w>k", { noremap = true, silent = true, desc = "Go to upper window" })
map("n", "<leader>l", "<c-w>l", { noremap = true, silent = true, desc = "Go to right window" })

map("n", "sj", "<cmd>split<cr>", { noremap = true, silent = true })
map("n", "sk", "<cmd>vsplit<cr>", { noremap = true, silent = true })
map("n", "sh", "<c-w>b<c-w>K", { noremap = true, silent = true })
map("n", "sv", "<c-w>b<c-w>H", { noremap = true, silent = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +5<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -5<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { silent = true, desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { silent = true, desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { silent = true, desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { silent = true, desc = "Move up" })
map("v", "<A-j>", "<cmd>m '>+1<cr>gv=gv", { silent = true, desc = "Move down" })
map("v", "<A-k>", "<cmd>m '<-2<cr>gv=gv", { silent = true, desc = "Move up" })

-- Buffers management
map("n", "bp", "<cmd>bprevious<cr>", { noremap = true, silent = true, desc = "Prev buffer" })
map("n", "bn", "<cmd>bnext<cr>", { noremap = true, silent = true, desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { noremap = true, silent = true, desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { noremap = true, silent = true, desc = "Next buffer" })
map("n", "bd", "<cmd>bdelete<cr>", { noremap = true, silent = true, desc = "Delete buffer" })
map("n", "<c-tab>", "<cmd>e #<cr>", { noremap = true, silent = true, desc = "Switch to Other Buffer" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

map("n", "[q", vim.cmd.cprev, { noremap = true, silent = true, desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { noremap = true, silent = true, desc = "Next quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Diagnostic list" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Terminal Mappings
map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<c-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-q>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Useful actions
map({ "n", "v" }, ",.", "%", { noremap = true, silent = true })
map("n", "\\v", "v$h", { noremap = true, silent = true })
map("n", ",v", "v%", { noremap = true, silent = true })
map("i", "<s-enter>", "<esc>o", { noremap = true, silent = true })
map("n", "s", "<nop>", { noremap = true, silent = true })
