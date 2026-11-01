local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_deep_extend('force', { silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

map({ 'n', 'i', 'v' }, '<C-s>', '<Cmd>update<CR><Esc>', { desc = 'Save and go to Normal mode' })
map({ 'n', 'v' }, '<Leader>qq', '<Cmd>qa<CR>', { desc = 'Quit All' })

map({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
map('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
map('x', 'gp', '"+P', { desc = 'Paste from system clipboard' })

map('n', '<Leader>rc', '<Cmd>e $MYVIMRC<CR>', { desc = 'Edit Configuration' })

-- better indent
map('n', '>', '>>')
map('n', '<', '<<')
map({ 'v', 'x' }, '>', '>gv')
map({ 'v', 'x' }, '<', '<gv')

map('', 'x', '"_x')
map('', 'X', '"_X')

-- Better up/down
map({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Add bash shortcuts for command line
map('c', '<C-a>', '<Home>')
map('c', '<C-e>', '<End>')
map('c', '<C-b>', '<Left>')
map('c', '<C-f>', '<Right>')
-- BASH-style movement in insert mode
map('i', '<C-a>', '<C-o>^')
map('i', '<C-e>', '<C-o>$')

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<Cmd>resize +5<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<Cmd>resize -5<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<Cmd>vertical resize -5<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<Cmd>vertical resize +5<CR>', { desc = 'Increase window width' })

-- Move Lines
map('n', '<M-j>', '<Cmd>m .+1<CR>==', { desc = 'Move down' })
map('n', '<M-k>', '<Cmd>m .-2<CR>==', { desc = 'Move up' })
map('i', '<M-j>', '<Esc><Cmd>m .+1<CR>==gi', { desc = 'Move down' })
map('i', '<M-k>', '<Esc><Cmd>m .-2<CR>==gi', { desc = 'Move up' })
map('v', '<M-j>', "<Cmd>m '>+1<CR>gv=gv", { desc = 'Move down' })
map('v', '<M-k>', "<Cmd>m '<-2<CR>gv=gv", { desc = 'Move up' })

-- Buffers management
map('n', '<S-h>', '<Cmd>bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '[b', '<Cmd>bprevious<CR>', { desc = 'Prev buffer' })
map('n', ']b', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<Leader>bd', '<Cmd>bdelete<CR>', { desc = 'Delete buffer' })
map('n', '<C-Tab>', '<Cmd>e #<CR>', { desc = 'Switch to Other Buffer' })

-- windows
map('n', '<Leader>ww', '<C-w>p', { desc = 'Other Window', remap = true })
map('n', '<Leader>wd', '<C-w>c', { desc = 'Delete Window', remap = true })
map('n', '<Leader>w-', '<C-w>s', { desc = 'Split Window Below', remap = true })
map('n', '<Leader>w|', '<C-w>v', { desc = 'Split Window Right', remap = true })

-- tabs
map('n', '<Leader><Tab>l', '<Cmd>tablast<CR>', { desc = 'Last Tab' })
map('n', '<Leader><Tab>f', '<Cmd>tabfirst<CR>', { desc = 'First Tab' })
map('n', '<Leader><Tab><Tab>', '<Cmd>tabnew<CR>', { desc = 'New Tab' })
map('n', '<Leader><Tab>]', '<Cmd>tabnext<CR>', { desc = 'Next Tab' })
map('n', '<Leader><Tab>c', '<Cmd>tabclose<CR>', { desc = 'close Tab' })
map('n', '<Leader><Tab>[', '<Cmd>tabprevious<CR>', { desc = 'Previous Tab' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', ';', ';<C-g>u')

--keywordprg
map('n', '<Leader>K', '<Cmd>norm! K<CR>', { desc = 'Keywordprg' })

-- commenting
map('n', 'gco', 'o<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<bs>', { desc = 'Add Comment Below' })
map('n', 'gcO', 'O<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<bs>', { desc = 'Add Comment Above' })

-- location list
map('n', '<Leader>xl', function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Location List' })

-- quickfix list
map('n', '<Leader>xq', function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Quickfix List' })

map('n', '[q', vim.cmd.cprev, { desc = 'Previous quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' })

-- diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
map('n', '<Leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', '<Leader>e', vim.diagnostic.setloclist, { desc = 'Diagnostic list' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- Terminal Mappings
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Enter Normal Mode' })
map('t', '<C-h>', '<Cmd>wincmd h<CR>', { desc = 'Go to left window' })
map('t', '<C-j>', '<Cmd>wincmd j<CR>', { desc = 'Go to lower window' })
map('t', '<C-k>', '<Cmd>wincmd k<CR>', { desc = 'Go to upper window' })
map('t', '<C-l>', '<Cmd>wincmd l<CR>', { desc = 'Go to right window' })
map('t', '<C-q>', '<Cmd>close<CR>', { desc = 'Hide Terminal' })
map('t', '<C-/>', '<Cmd>close<CR>', { desc = 'Hide Terminal' })

-- lazy
map('n', '<Leader>l', '<Cmd>Lazy<CR>', { desc = 'Lazy' })

local Util = require('util')
-- stylua: ignore start
-- toggle options
map('n', '<Leader>ub', function() Util.toggle('background', false, { 'light', 'dark' }) end,
  { desc = 'Toggle Background' })
map('n', '<Leader>ul', function() Util.toggle.number() end, { desc = 'Toggle Line Numbers' })
map('n', '<Leader>uL', function() Util.toggle('relativenumber') end, { desc = 'Toggle Relative Line Numbers' })
map('n', '<Leader>us', function() Util.toggle('spell') end, { desc = 'Toggle Spelling' })
map('n', '<Leader>uw', function() Util.toggle('wrap') end, { desc = 'Toggle Word Wrap' })
-- stylua: ignore end

map('n', '<Leader>ud', function()
  local value = not vim.diagnostic.is_enabled()
  vim.diagnostic.enable(value)
  vim.notify((value and 'Enabled ' or 'Disabled ') .. 'Diagnostics', vim.log.levels.INFO, { title = 'Diagnostics' })
end, { desc = 'Toggle Diagnostics' })

map('n', '<Leader>uf', function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify(
    (vim.g.autoformat and 'Enabled ' or 'Disabled ') .. 'Auto Format',
    vim.log.levels.INFO,
    { title = 'Auto Format' }
  )
end, { desc = 'Toggle Auto Format' })

-- highlights under cursor
map('n', '<Leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
map('n', '<Leader>uI', function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input('I')
end, { desc = 'Inspect Tree' })

map('n', '<Leader>rr', function()
  Util.run_file.run()
end, { desc = 'Run Current File' })

-- Disable `s`、`S`
map('', 's', '<Nop>')
map('', 'S', '<Nop>')
