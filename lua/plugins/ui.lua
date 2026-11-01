return {
  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = { 'BufRead', 'BufNewFile' },
    opts = {},
  },

  -- Tabline
  {
    'akinsho/bufferline.nvim',
    event = { 'BufRead', 'BufNewFile' },
    keys = {
      { '<Leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<Leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<Leader>bb', '<Cmd>BufferLinePick<CR>', desc = 'BufferLine Pick' },
      { '<Leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<Leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<Leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
      { '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev Buffer' },
      { '<S-l>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next Buffer' },
      { '[b', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev Buffer' },
      { ']b', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next Buffer' },
      { '[B', '<Cmd>BufferLineMovePrev<CR>', desc = 'Move buffer prev' },
      { ']B', '<Cmd>BufferLineMoveNext<CR>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(_, _, diag)
          local icons = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
            .. (diag.warning and icons.Warn .. diag.warning .. ' ' or '')
            .. (diag.hint and icons.Hint .. diag.hint .. ' ' or '')
            .. (diag.info and icons.Info .. diag.info or '')
          return vim.trim(ret)
        end,
        show_buffer_close_icons = false,
        show_close_icon = false,
        enforce_regular_tabs = true,
        show_duplicate_prefix = false,
        separator_style = 'thick',
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            text_align = 'left',
            highlight = 'Directory',
            separator = true,
          },
        },
      },
    },
  },

  -- Better Notify
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    -- stylua: ignore
    keys = {
      { '<C-f>', function() if not require('noice.lsp').scroll(4) then return '<C-f>' end end, silent = true, expr = true, desc = 'Scroll Forward', mode = {'i', 'n', 's'} },
      { '<C-b>', function() if not require('noice.lsp').scroll(-4) then return '<C-b>' end end, silent = true, expr = true, desc = 'Scroll Backward', mode = {'i', 'n', 's'} },
      { '<Leader>sn', '<Cmd>Noice history<CR>', desc = 'Show Notifications History' },
      { '<Leader>un', '<Cmd>Noice dismiss<CR>', desc = 'Dismiss all messages' },
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = false,
        lsp_doc_border = true,
      },
    },
    config = function(_, opts)
      vim.o.cmdheight = 0
      if vim.o.filetype == 'lazy' then
        vim.cmd([[messages clear]])
      end
      require('noice').setup(opts)
    end,
  },

  { 'MunifTanjim/nui.nvim', lazy = true },
}
