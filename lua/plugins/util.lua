return {

  -- library used by other plugins
  { 'nvim-lua/plenary.nvim', lazy = true },

  -- fantastic icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  { 'nmac427/guess-indent.nvim', event = { 'BufReadPre', 'BufNewFile' }, opts = {} },
}
