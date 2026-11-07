return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter').update()
    end,
    cmd = { 'TSInstall', 'TSInstallFromGrammar', 'TSUpdate', 'TSUninstall', 'TSLog' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'rust',
        'toml',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      }

      local TS = require('nvim-treesitter')
      local installed = TS.get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure_installed)
      if #to_install > 0 then
        TS.install(to_install)
        vim.list_extend(installed, to_install)
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = installed,
        callback = function(ev)
          vim.treesitter.start(ev.buf)
          vim.wo[0].foldmethod = 'expr'
          vim.wo[0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo[ev.buf].indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('nvim-treesitter-textobjects').setup({
        move = { set_jumps = true },
      })

      -- select
      vim.keymap.set({ 'x', 'o' }, 'aa', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@parameter.outer', 'textobjects')
      end, { desc = 'Parameter', silent = true })
      vim.keymap.set({ 'x', 'o' }, 'ia', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@parameter.inner', 'textobjects')
      end, { desc = 'Parameter', silent = true })
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
      end, { desc = 'Function', silent = true })
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
      end, { desc = 'Function', silent = true })
      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
      end, { desc = 'Class', silent = true })
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
      end, { desc = 'Class', silent = true })

      -- swap
      vim.keymap.set('n', '<Leader>a', function()
        require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
      end, { desc = 'Swap With The Next Parameter', silent = true })
      vim.keymap.set('n', '<Leader>A', function()
        require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
      end, { desc = 'Swap With The Previous Parameter', silent = true })

      -- stylua: ignore
      ---@type table<string, table<string, string>>
      local moves = {  -- textobjects
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
        goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
        goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
      }
      for method, keymaps in pairs(moves) do
        for key, query in pairs(keymaps) do
          local queries = type(query) == 'table' and query or { query }
          local parts = {}
          for _, q in ipairs(queries) do
            local part = q:gsub('@', ''):gsub('%..*', '')
            part = part:sub(1, 1):upper() .. part:sub(2)
            table.insert(parts, part)
          end
          local desc = table.concat(parts, ' or ')
          desc = (key:sub(1, 1) == '[' and 'Prev ' or 'Next ') .. desc
          desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and ' End' or ' Start')
          vim.keymap.set({ 'n', 'x', 'o' }, key, function()
            if vim.wo.diff and key:find('[cC]') then
              vim.cmd.normal({ key, bang = true })
              return
            end
            require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
          end, { desc = desc, silent = true })
        end
      end
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'InsertEnter' },
    opts = {},
  },
}
