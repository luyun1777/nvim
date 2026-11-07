local function augroup(name)
  return vim.api.nvim_create_augroup('lazy_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ 'LspAttach', 'BufFilePost', 'DirChanged', 'BufEnter' }, {
  group = augroup('root_cache'),
  callback = function(ev)
    require('util.root').clear_cache(ev.buf or vim.api.nvim_get_current_buf())
  end,
})

-- Auto restore cursor position to last location
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(ev)
    local exclude = { 'gitcommit', 'gitrebase', 'help', 'dashboard' }
    local buf = ev.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      local win = vim.fn.bufwinid(buf)
      if win ~= -1 then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end
  end,
})

-- Auto enter insert mode while enter a terminal
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
  group = augroup('startinsert'),
  pattern = 'term://*',
  callback = function(ev)
    if vim.bo[ev.buf].buftype == 'terminal' then
      vim.cmd('startinsert')
    end
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    if vim.fn.has('nvim-0.13') == 1 then
      vim.hl.hl_op()
    else
      (vim.hl or vim.highlight).on_yank()
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dap-float',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd('close')
        pcall(vim.api.nvim_buf_delete, ev.buf, { force = true })
      end, { buf = ev.buf, silent = true, desc = 'Quit buffer' })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('man_unlisted'),
  pattern = { 'man' },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function(ev)
    for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
      vim.wo[win].spell = true
      vim.wo[win].wrap = true
    end
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function(ev)
    for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
      vim.wo[win].conceallevel = 0
    end
  end,
})

-- Auto set tab's length to 2
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('tabs_to_2_spaces'),
  pattern = { 'lua', 'markdown', 'yaml' },
  callback = function(ev)
    local bo = vim.bo[ev.buf]
    bo.shiftwidth = 2
    bo.softtabstop = 2
    bo.tabstop = 2
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(ev)
    if ev.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
