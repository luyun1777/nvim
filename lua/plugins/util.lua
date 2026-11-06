return {
  { 'nvim-lua/plenary.nvim', lazy = true }, -- library used by other plugins

  { 'nvim-tree/nvim-web-devicons', lazy = true }, -- fantastic icons

  { 'nmac427/guess-indent.nvim', event = { 'BufRead', 'BufNewFile' }, opts = {} },
}
