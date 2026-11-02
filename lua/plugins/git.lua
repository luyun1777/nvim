return {
  {
    'lewis6991/gitsigns.nvim',
    enabled = vim.fn.executable('git') == 1,
    cmd = 'Gitsigns',
    event = { 'BufRead', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      preview_config = { border = 'rounded' },
      -- current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buf = bufnr, desc = desc })
        end

        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, 'Next Hunk')
        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, 'Prev Hunk')
        -- stylua: ignore start
        map('n', ']H', function() gs.nav_hunk('last') end, 'Last Hunk')
        map('n', '[H', function() gs.nav_hunk('first') end, 'First Hunk')
        map({ 'n', 'v' }, '<Leader>gr', '<Cmd>Gitsigns reset_hunk<CR>', 'Reset hunk')
        map({ 'n', 'v' }, '<Leader>gR', gs.reset_buffer, 'Reset Buffer')
        map({ 'n', 'v' }, '<Leader>ghs', '<Cmd>Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'v' }, '<Leader>ghr', '<Cmd>Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map({ 'n', 'v' }, '<Leader>ghR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<Leader>ghS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<Leader>ghu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<Leader>ghp', gs.preview_hunk_inline, 'Preview Hunk Inline')
        map('n', '<Leader>ghb', function() gs.blame_line({ full = true }) end, 'Blame Line')
        map('n', '<Leader>ghB', function() gs.blame() end, 'Blame Buffer')
        map('n', '<Leader>ghl', function() gs.toggle_current_line_blame() end, 'Blame Current Line')
        map('n', '<Leader>ghd', gs.diffthis, 'Diff This')
        map('n', '<Leader>ghD', function() gs.diffthis('~') end, 'Diff This ~')
        map({ 'o', 'x' }, 'ih', '<Cmd>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
        -- stylua: ignore end
      end,
    },
  },
}
