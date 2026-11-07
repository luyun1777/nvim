local icons = {
  [vim.diagnostic.severity.ERROR] = ' ',
  [vim.diagnostic.severity.WARN] = ' ',
  [vim.diagnostic.severity.HINT] = ' ',
  [vim.diagnostic.severity.INFO] = ' ',
}

---@type vim.diagnostic.Opts.VirtualText
local virtual_text = {
  spacing = 4,
  source = 'if_many',
  prefix = function(diagnostic)
    return icons[diagnostic.severity] or '●'
  end,
}

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  float = { source = 'if_many' },
  virtual_text = vim.g.enable_virtual_text and virtual_text,
  severity_sort = true,
  signs = { text = icons },
})

vim.keymap.set('n', '<Leader>uv', function()
  vim.g.enable_virtual_text = not vim.g.enable_virtual_text
  vim.diagnostic.config({ virtual_text = vim.g.enable_virtual_text and virtual_text })
  vim.notify(
    (vim.g.enable_virtual_text and 'Enabled' or 'Disabled') .. ' `virtual_text`',
    vim.log.levels.INFO,
    { title = 'Virtual Text' }
  )
end, { desc = 'Toggle virtual_text (diagnostic)' })

-- copy from `https://github.com/saghen/blink.cmp/blob/main/lua/blink/cmp/sources/lib/init.lua`
---@type lsp.ClientCapabilities
local capabilities = {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true,
        commitCharactersSupport = false, -- TODO:
        documentationFormat = { 'markdown', 'plaintext' },
        deprecatedSupport = true,
        preselectSupport = false, -- TODO:
        tagSupport = { valueSet = { 1 } }, -- deprecated
        insertReplaceSupport = true, -- TODO:
        resolveSupport = {
          properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
            'command',
            'data',
            -- TODO: support more properties? should test if it improves latency
          },
        },
        insertTextModeSupport = {
          -- TODO: support adjustIndentation
          valueSet = { 1 }, -- asIs
        },
        labelDetailsSupport = true,
      },
      completionList = {
        itemDefaults = {
          'commitCharacters',
          'editRange',
          'insertTextFormat',
          'insertTextMode',
          'data',
        },
      },

      contextSupport = true,
      insertTextMode = 1, -- asIs
    },
  },
}
capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), capabilities)
capabilities = vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
})
-- Set default capabilities for all LSP servers
vim.lsp.config('*', { capabilities = capabilities })

vim.lsp.enable({ 'clangd', 'lua_ls', 'rust_analyzer', 'ty' })
-- vim.lsp.enable('emmylua_ls')

local format_group = vim.api.nvim_create_augroup('lsp_autoformat', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = format_group,
  callback = function(ev)
    if not vim.g.autoformat then
      return
    end
    if pcall(require, 'conform') then
      return
    end
    local bufnr = ev.buf
    local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/formatting' })
    if #clients == 0 then
      return
    end

    vim.lsp.buf.format({ bufnr = bufnr })
  end,
})

local has_snacks, _ = pcall(require, 'snacks')
if not has_snacks then
  if vim.fn.has('nvim-0.12') == 1 then
    vim.keymap.set('n', '<Leader>cl', '<Cmd>checkhealth vim.lsp<CR>', { desc = 'Lsp Info' })
  else
    vim.keymap.set('n', '<Leader>cl', '<Cmd>LspInfo<CR>', { desc = 'Lsp Info' })
  end
end
-- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_keymaps', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return
    end
    local bufnr = ev.buf
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('force', { buf = bufnr }, opts or {})
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- CodeLens
    if client:supports_method('textDocument/codeLens', bufnr) then
      vim.lsp.codelens.enable(true, { bufnr = bufnr })
      map('n', '<Leader>cc', vim.lsp.codelens.run, { desc = 'Run CodeLens' })
      map('n', '<Leader>cC', function()
        require('util.toggle').codelens()
      end, { desc = 'Toggle CodeLens' })
    end

    --Folds
    if client:supports_method('textDocument/foldingRange', bufnr) then
      for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
        vim.wo[win].foldmethod = 'expr'
        vim.wo[win].foldexpr = 'v:lua.vim.lsp.foldexpr()'
      end
    end

    -- Inlay Hints
    if client:supports_method('textDocument/inlayHint', bufnr) then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

      if not has_snacks then
        map('n', '<Leader>uh', function()
          require('util.toggle').inlay_hints()
        end, { desc = 'Toggle Inlay Hints' })
      end
    end

    -- Completion & Tags
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'
    end

    if not has_snacks then
      map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go Declaration' })
      map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go Definition' })
      map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go Implementation' })
      map('n', 'gr', vim.lsp.buf.references, { desc = 'Go References' })
      map('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto T[y]pe Definition' })
    end

    map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
    map('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Signature help' })
    map('n', '<Leader>rn', vim.lsp.buf.rename, { desc = 'Rename variable' })
    map({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
    map('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
    map('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
    map('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
    map('n', '<Leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = 'List workspace folders' })
  end,
})
