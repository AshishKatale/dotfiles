local M = {
  'williamboman/mason.nvim',
  lazy = true,
  event = { 'VeryLazy' },
  build = ':MasonUpdate',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },
}

M.opts = function()
  return {
    mason = {
      ui = {
        check_outdated_packages_on_open = true,
        border = 'rounded',
        width = 0.8,
        height = 0.8,
      }
    },
    mason_lspconfig = {
      -- A list of servers to automatically install if not already installed.
      -- This setting has no relation with the `automatic_installation` setting.
      ensure_installed = {
        'lua_ls', 'ts_ls', 'jsonls',
        'html', 'emmet_language_server', 'cssls',
        'eslint', 'tailwindcss', 'yamlls',
        'texlab', 'gopls', 'dockerls',
      },
      -- Whether servers that are set up (via lspconfig) should be automatically
      -- installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      automatic_installation = false,

      handlers = {
        function(lsp_name) vim.lsp.enable(lsp_name) end
      },
    }
  }
end

M.config = function(_, opts)
  local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('blink.cmp').get_lsp_capabilities({}, false)
  )

  require('custom.plugins.utils.nvimlsp').setup()
  vim.lsp.config('*', { capabilities = capabilities })

  require('mason').setup(opts.mason)
  require('mason-lspconfig').setup(opts.mason_lspconfig)

  -- externally installed language servers (without meson)
  vim.lsp.enable('rust_analyzer')
  vim.lsp.enable('hls')
end

return M
