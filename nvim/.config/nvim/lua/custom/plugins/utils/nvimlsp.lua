local which_key_status_ok, which_key = pcall(require, 'which-key')
if not which_key_status_ok then
  vim.notify('Unable to load: whichkey')
  return
end

local augroup = vim.api.nvim_create_augroup('lspcursor', { clear = true })
local function enable_lsp_features(client, bufnr)
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

local function set_lsp_keymaps(bufnr)
  local utils = require('custom.plugins.utils.fn')
  which_key.add({
    {
      'K',
      '<cmd>lua vim.lsp.buf.hover({ max_width=100, border="rounded" })<CR>',
      desc = 'LSP Code action',
      buffer = bufnr
    },

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
      focusable = false,
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
      enable_lsp_features(client, ev.buf)
    end
  })
end

return M
