local root = require('util.root')

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    -- image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            ['<Tab>'] = { 'list_down', mode = { 'i', 'n' } },
            ['<S-Tab>'] = { 'list_up', mode = { 'i', 'n' } },
            ['<C-h>'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
            ['<C-l>'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
          },
        },
      },
    },

    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = { enabled = true, win = { position = 'float', border = 'rounded' } },
    words = { enabled = true },
  },
  keys = {
  -- stylua: ignore start
    { '<Leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
    { '<Leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<Leader>/', function() Snacks.picker.grep({ cwd = root.get() }) end, desc = 'Grep (Root Dir)' },
    { '<Leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<Leader>n',  function() Snacks.notifier.show_history() end, desc = 'Show Notification History' },
    { '<Leader>fn', function() Snacks.picker.notifications() end, desc = 'Find Notification History' },
    { '<Leader>fe', function() Snacks.explorer({ cwd = root.get() }) end, desc = 'Explorer Snacks (Root Dir)' },
    { '<Leader>fE', function() Snacks.explorer() end, desc = 'Explorer Snacks (Cwd)' },
    -- find
    { '<Leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<Leader>fB', function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = 'Buffers (all)' },

    { '<Leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = 'Find Config File' },
    { '<Leader>ff', function() Snacks.picker.files({ cwd = root.get() }) end, desc = 'Find Files (Root Dir)' },
    { '<Leader>fF', function() Snacks.picker.files({ cwd = vim.uv.cwd() }) end, desc = 'Find Files (Cwd)' },
    { '<Leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
    { '<Leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
    { '<Leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },
    { '<Leader>fR', function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = 'Recent (cwd)' },
    -- git
    { '<Leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
    { '<Leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
    { '<Leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
    { '<Leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
    { '<Leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
    { '<Leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
    { '<Leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },
    -- Grep
    { '<Leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
    { '<Leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    { '<Leader>sg', function() Snacks.picker.grep({ cwd = root.get() }) end, desc = 'Grep (Root Dir)' },
    { '<Leader>sG', function() Snacks.picker.grep({ cwd = vim.uv.cwd()}) end, desc = 'Grep (Cwd)' },
    { '<Leader>sw', function() Snacks.picker.grep_word({ cwd = root.get() }) end, desc = 'Visual selection or word (Root Dir)', mode = { 'n', 'x' } },
    { '<Leader>sW', function() Snacks.picker.grep_word({ cwd = vim.uv.cwd()}) end, desc = 'Visual selection or word (Cwd)', mode = { 'n', 'x' } },
    -- search
    { '<Leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
    { '<Leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    { '<Leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
    { '<Leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<Leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
    { '<Leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<Leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
    { '<Leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<Leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
    { '<Leader>si', function() Snacks.picker.icons() end, desc = 'Icons' },
    { '<Leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
    { '<Leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<Leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
    { '<Leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    { '<Leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages' },
    { '<Leader>sp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec' },
    { '<Leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
    { '<Leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
    { '<Leader>su', function() Snacks.picker.undo() end, desc = 'Undo History' },
    { '<Leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
    -- LSP
    { '<Leader>cl', function() Snacks.picker.lsp_config() end, desc = 'Lsp Info' },
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
    { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
    { 'gi', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
    { '<Leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
    { '<Leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
    -- Other
    { '<Leader>uz',  function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
    { '<Leader>uZ',  function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
    { '<Leader>.',  function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    { '<Leader>S',  function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
    { '<Leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    { '<Leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
    { '<Leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
    { '<Leader>gg', function() Snacks.lazygit({ cwd = root.get() }) end, desc = 'Lazygit (Root Dir)' },
    { '<Leader>gG', function() Snacks.lazygit() end, desc = 'Lazygit (Cwd)' },
    { '<Leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
    { '<Leader>tt', function() Snacks.terminal(nil, { cwd = root.get() }) end, desc = 'Terminal (Float & Root Dir)' },
    { '<Leader>tT', function() Snacks.terminal() end, desc = 'Terminal (Float & Cwd)' },
    { '<Leader>tf', function() Snacks.terminal(nil, { cwd = root.get() } ) end, desc = 'Terminal (Float & Root Dir)' },
    { '<Leader>tF', function() Snacks.terminal() end, desc = 'Terminal (Float & Cwd)' },
    { '<Leader>tv', function() Snacks.terminal(nil, { cwd = root.get(), count = 2, win = { position = 'bottom', height = 0.4 } }) end, desc = 'Terminal (Bottom & Root Dir)' },
    { '<Leader>tV', function() Snacks.terminal(nil, { count = 2, win = { position = 'bottom', height = 0.4 } }) end, desc = 'Terminal (Bottom & Cwd)' },
    { '<Leader>th', function() Snacks.terminal(nil, { cwd = root.get(), count = 3, win = { position = 'right', width = 0.3 } }) end, desc = 'Terminal (Right & Root Dir)' },
    { '<Leader>tH', function() Snacks.terminal(nil, { count = 3, win = { position = 'right', width = 0.3 } }) end, desc = 'Terminal (Right & Cwd)' },
    { '<C-/>',      function() Snacks.terminal.toggle(nil, { cwd = root.get() }) end, desc = 'Terminal (Toggle)' },
    { '<C-_>',      function() Snacks.terminal() end, desc = 'which_key_ignore', mode = { 'n', 't' } },
    { ']]',         function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
    { '[[',         function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
    -- stylua: ignore end
    {
      '<Leader>N',
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          border = 'rounded',
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        })
      end,
      desc = 'Neovim News',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map('<Leader>us')
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<Leader>uw')
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<Leader>uL')
        Snacks.toggle.inlay_hints():map('<Leader>uh')
        Snacks.toggle.diagnostics():map('<Leader>ud')
        Snacks.toggle.line_number():map('<Leader>ul')
        Snacks.toggle
          .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map('<Leader>uc')
        Snacks.toggle.treesitter():map('<Leader>uT')
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<Leader>ub')
        Snacks.toggle.animate():map('<Leader>ua')
        Snacks.toggle.indent():map('<Leader>ug')
        Snacks.toggle.dim():map('<Leader>uD')
        Snacks.toggle.scroll():map('<Leader>uS')

        local prev = { new_name = '', old_name = '' } -- Prevents duplicate events
        vim.api.nvim_create_autocmd('User', {
          pattern = 'NvimTreeSetup',
          callback = function()
            local events = require('nvim-tree.api').events
            events.subscribe(events.Event.NodeRenamed, function(data)
              if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
                data = data
                Snacks.rename.on_rename_file(data.old_name, data.new_name)
              end
            end)
          end,
        })
      end,
    })
  end,
}
