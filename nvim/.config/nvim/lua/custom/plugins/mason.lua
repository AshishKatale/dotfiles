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
        'lua_ls', 'ts_ls', 'jsonls', 'html',
        'emmet_language_server', 'eslint', 'dockerls',
        'cssls', 'tailwindcss', 'gopls',
      },
      -- Whether servers that are set up (via lspconfig) should be automatically
      -- installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      automatic_installation = false,
    }
  }
end

M.config = function(_, opts)
  require('custom.plugins.utils.nvimlsp').setup()
  require('mason').setup(opts.mason)
  require('mason-lspconfig').setup(opts.mason_lspconfig)

  local lspconfig = require('lspconfig')
  local handlers = require('custom.plugins.utils.handlers')

  require('mason-lspconfig').setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      lspconfig[server_name].setup({
        inlay_hints = { enabled = true },
        capabilities = handlers.capabilities
      })
    end,

    -- Next, you can provide a dedicated handler for specific servers.
    [handlers.ls.lua] = function(server_name)
      lspconfig[server_name].setup(handlers.lsp_settings[server_name])
    end,

    [handlers.ls.tailwindcss] = function(server_name)
      lspconfig[server_name].setup(handlers.lsp_settings[server_name])
    end,
  })

  -- external lsp servers (not installed with mason)
  lspconfig.rust_analyzer.setup(handlers.lsp_settings[handlers.ls.rust])
  -- lspconfig.gopls.setup(handlers.lsp_settings[handlers.ls.go])
end

return M
