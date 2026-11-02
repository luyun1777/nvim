return {
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle' },
    keys = {
      {
        'tt',
        function()
          require('nvim-tree.api').tree.toggle({ path = require('util.root').get(), find_file = true })
        end,
        desc = 'Toggle NvimTree (Root Dir)',
      },
      {
        'te',
        function()
          require('nvim-tree.api').tree.toggle({ path = vim.uv.cwd(), find_file = true })
        end,
        desc = 'Toggle NvimTree (Cwd)',
      },
    },
    ---@type nvim_tree.config
    opts = {
      renderer = { indent_markers = { enable = true } },
      filters = { dotfiles = true, git_ignored = true },
    },
  },
  {
    'mikavilpas/yazi.nvim',
    enabled = vim.fn.executable('yazi') == 1,
    cmd = 'Yazi',
    keys = {
      {
        '<Leader>-',
        '<Cmd>Yazi<CR>',
        desc = 'Open yazi at the current file',
      },
      {
        '<Leader>cw',
        '<Cmd>Yazi cwd<CR>',
        desc = 'Open the file manager in working directory',
      },
    },
    opts = {
      open_for_directories = false,
    },
  },

  -- Better move
  {
    'folke/flash.nvim',
    ---@type Flash.Config
    opts = {
      search = { incremental = true },
      label = { rainbow = { enable = true } },
    },

    keys = {
    -- stylua: ignore start
      { 's', function() require('flash').jump() end, desc = 'Flash' },
      { 'S', function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', function() require('flash').remote() end, mode = 'o', desc = 'Remote Flash' },
      { 'R', function() require('flash').treesitter_search() end, mode = { 'o', 'x' }, desc = 'Treesitter Search' },
      { '<C-s>', function() require('flash').toggle() end, mode = { 'c' }, desc = 'Toggle Flash Search' },
      -- stylua: ignore end
      -- Simulate nvim-treesitter incremental selection
      {
        '<CR>',
        function()
          require('flash').treesitter({
            actions = {
              ['<CR>'] = 'next',
              ['<BS>'] = 'prev',
            },
          })
        end,
        mode = { 'n', 'o', 'x' },
        desc = 'Treesitter Incremental Selection',
      },
    },
  },
  -- Better fold
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = { 'BufRead', 'BufNewFile' },
    opts = {
      provider_selector = function(_, filetype, buftype)
        return (filetype == '' or buftype == 'nofile') and 'indent' or { 'treesitter', 'indent' }
      end,
    },
  },

  -- Better surrounding
  {
    'kylechui/nvim-surround',
    event = { 'BufRead', 'BufNewFile' },
    opts = {},
  },
  {
    'dstein64/nvim-scrollview',
    event = { 'BufRead', 'BufNewFile' },
    opts = {},
  },

  -- Other useful tool
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  -- search/replace in multiple files
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = { 'GrugFar', 'GrugFarWithin' },
    keys = {
      {
        '<Leader>sr',
        function()
          local grug = require('grug-far')
          local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
    },
  },

  { -- Rainbow delimiters
    'hiphish/rainbow-delimiters.nvim',
    event = { 'BufRead', 'BufNewFile' },
  },
  {
    'RRethy/vim-illuminate',
    event = { 'BufRead', 'BufNewFile' },
  },
  { -- Color indicator
    'NvChad/nvim-colorizer.lua',
    cmd = { 'ColorizerToggle' },
    keys = { { '<Leader>ct', '<Cmd>ColorizerToggle<CR>', desc = 'Toggle Colorizer' } },
    opts = {
      options = {
        parsers = { css = true, tailwind = { enable = true } },
        display = { mode = 'virtualtext' },
      },
    },
  },

  { -- Translate
    'voldikss/vim-translator',
    cmd = { 'Translate' },
    keys = {
      { '<Leader>tr', '<Plug>TranslateW', desc = 'Translate' },
      { '<Leader>tr', '<Plug>TranslateWV', mode = 'v', desc = 'Translate' },
    },
    init = function()
      vim.g.translator_default_engines = { 'bing', 'haici', 'youdao' }
      vim.g.translator_window_borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
    end,
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<Leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    opts = {
      preset = 'helix',
      spec = {
        {
          mode = { 'n', 'v' },
          { '<Leader>b', group = 'buffer' },
          { '<Leader>c', group = 'code' },
          { '<Leader>f', group = 'file/find' },
          { '<Leader>g', group = 'git' },
          { '<Leader>gh', group = 'hunks' },
          { '<Leader>s', group = 'search' },
          { '<Leader>t', group = 'terminal/translate' },
          { '<Leader>u', group = 'ui' },
          { '<Leader>w', group = 'windows' },
          { '<Leader>x', group = 'diagnostics/quickfix' },
          { '[', group = 'prev' },
          { ']', group = 'next' },
          { 'g', group = 'goto' },
          { 'z', group = 'fold' },
        },
      },
    },
  },
}
