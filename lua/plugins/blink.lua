return {
  'saghen/blink.cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  version = '1.*',
  dependencies = {
    { 'rafamadriz/friendly-snippets' },
    { 'onsails/lspkind.nvim' },
  },

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    completion = {
      documentation = { auto_show = true },
      list = { selection = { preselect = false } },
      menu = {
        draw = {
          treesitter = { 'lsp' },
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require('lspkind').symbol_map[ctx.kind] or ''
                end

                return icon .. ctx.icon_gap
              end,

              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
      },
    },

    keymap = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },
    -- experimental signature help support
    -- signature = { enabled = true },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100, -- show at a higher priority than lsp
        },
      },
    },

    cmdline = {
      enabled = true,
      keymap = {
        preset = 'cmdline',
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<Left>'] = false,
        ['<Right>'] = false,
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = { auto_show = true },
        ghost_text = { enabled = true },
      },
    },
  },
}
