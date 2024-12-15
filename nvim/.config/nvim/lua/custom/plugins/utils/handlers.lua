local which_key_status_ok, which_key = pcall(require, 'which-key')
if not which_key_status_ok then
  vim.notify('Unable to load: whichkey')
  return
end
local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  vim.notify('Unable to load: cmp_nvim_lsp')
  return
end

local enable_lsp_features = function(client, bufnr)
  local augroup = vim.api.nvim_create_augroup('lspcursor', { clear = true })
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorMoved' }, {
      callback = function(ev)
        if ev.event == 'CursorHold' then
          vim.lsp.buf.document_highlight()
          vim.diagnostic.open_float({ max_width = 100 })
        else
          vim.lsp.buf.clear_references()
        end
      end,
      buffer = bufnr,
      group = augroup
    })
  else
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      callback = function() vim.diagnostic.open_float({ max_width = 100 }) end,
      buffer = bufnr,
      group = augroup
    })
  end
end

local set_lsp_keymaps = function(bufnr)
  local utils = require('custom.plugins.utils.fn')
  which_key.add({
    { '<leader>', group = 'Leader' },
    {
      '<leader>c',
      '<cmd>lua vim.lsp.buf.code_action()<CR>',
      desc = 'LSP Code action',
      buffer = bufnr
    },
    {
      '<leader>r',
      '<cmd>lua vim.lsp.buf.rename()<CR>',
      desc = 'LSP rename',
      buffer = bufnr
    },
    {
      '<leader>f',
      '<cmd>lua vim.lsp.buf.format({ timeout_ms = 10000 })<CR>',
      desc = 'Format Document',
      buffer = bufnr
    },
    {
      '<leader>f',
      utils.range_format,
      desc = 'format selection',
      buffer = bufnr,
      mode = { 'v' },
    },

    { 'g',        group = 'Go to' },
    {
      'gd',
      '<cmd>lua vim.lsp.buf.definition()<CR>',
      desc = 'Definition',
      buffer = bufnr
    },
    {
      'gD',
      '<cmd>lua vim.lsp.buf.declaration()<CR>',
      desc = 'Declaration',
      buffer = bufnr
    },
    {
      'gI',
      '<cmd>lua vim.lsp.buf.implementation()<CR>',
      desc = 'Implementation',
      buffer = bufnr
    },
    {
      'gr',
      '<cmd>Trouble lsp_references<CR>',
      desc = 'References trouble',
      buffer = bufnr
    },
    {
      'gR',
      '<cmd>Telescope lsp_references<CR>',
      desc = 'References telescope',
      buffer = bufnr
    },
    {
      'gs',
      '<cmd>Telescope lsp_document_symbols<CR>',
      desc = 'File symbols',
      buffer = bufnr
    },
    {
      'gS',
      '<cmd>Telescope lsp_workspace_symbols<CR>',
      desc = 'Workspace symbols',
      buffer = bufnr
    },
    {
      'gp',
      '<cmd>lua vim.diagnostic.goto_prev()<CR>',
      desc = 'Pervious diagnostic',
      buffer = bufnr
    },
    {
      'gn',
      '<cmd>lua vim.diagnostic.goto_next()<CR>',
      desc = 'Next diagnostic',
      buffer = bufnr
    },
    {
      'gt',
      '<cmd>lua vim.lsp.buf.type_definition()<CR>',
      desc = 'Type Definition',
      buffer = bufnr
    },
  })
end

local M = {}
M.capabilities = cmp_nvim_lsp.default_capabilities()
M.on_attach = function(client, bufnr)
  set_lsp_keymaps(bufnr)
  enable_lsp_features(client, bufnr)
end

M.lsp_settings = {
  ['lua_ls'] = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
      Lua = {
        runtime = { version = 'Lua 5.1' },
        diagnostics = {
          globals = { 'vim' },
        },
      },
    }
  },
  ['rust_analyzer'] = {
    cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  },
  ['gopls'] = {
    cmd = { 'gopls', 'serve' },
    filetypes = { 'go', 'gomod' },
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  ['tailwindcss'] = {
    autostart = false
  }
}

return M
