local which_key_status_ok, which_key = pcall(require, 'which-key')
if not which_key_status_ok then
  vim.notify('Unable to load: whichkey')
  return
end

local augroup = vim.api.nvim_create_augroup('lspcursor', { clear = true })
local function configure_lsp_features(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorMoved' }, {
      callback = function(ev)
        if ev.event == 'CursorHold' then
          vim.lsp.buf.document_highlight()
          vim.diagnostic.open_float()
        else
          vim.lsp.buf.clear_references()
        end
      end,
      buffer = bufnr,
      group = augroup
    })
  else
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      callback = vim.diagnostic.open_float,
      buffer = bufnr,
      group = augroup
    })
  end

  if client.server_capabilities.foldingRangeProvider then
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
  end

  if client and client.name == 'clangd' then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local function set_lsp_keymaps(bufnr)
  local utils = require('custom.plugins.utils.fn')
  which_key.add({
    {
      'K',
      '<cmd>lua vim.lsp.buf.hover({max_width=100,max_height=24,border="rounded"})<CR>',
      desc = 'LSP hover',
      buffer = bufnr
    },

    {
      '<leader>a',
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

    { 'g', group = 'Go to' },
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
      'gs',
      function() require('snacks').picker.lsp_symbols() end,
      desc = 'File symbols',
      buffer = bufnr
    },
    {
      'gS',
      function() require('snacks').picker.lsp_workspace_symbols() end,
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
  })
end

local M = {}

M.setup = function()
  vim.diagnostic.config({
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      text = {
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '󰘥',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.ERROR] = '󰅚',
      }
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      max_width = 100,
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = true,
      header = '',
      prefix = '',
    },
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      set_lsp_keymaps(ev.buf)
      configure_lsp_features(client, ev.buf)
    end
  })
end

return M
