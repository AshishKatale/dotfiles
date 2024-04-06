local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  print("Unable to load: mason")
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  print("Unable to load: mason-lspconfig")
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  print("Unable to load: lspconfig")
  return
else
  require('lspconfig.ui.windows').default_options.border = 'rounded'
end

local handlers_status_ok, handlers = pcall(require, "user.plugins.lsp.handlers")
if not handlers_status_ok then
  print("Unable to load: user.plugins.lsp.handlers")
  return
end

mason.setup({
  ui = {
    check_outdated_packages_on_open = true,
    border = "rounded",
    width = 0.8,
    height = 0.8,
  }
})
mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed.
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = {
    "lua_ls", "tsserver", "jsonls", "html",
    "emmet_language_server", "eslint", "dockerls",
    "svelte", "cssls", "tailwindcss", "gopls",
  },
  -- Whether servers that are set up (via lspconfig) should be automatically
  -- installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  automatic_installation = false,
})

mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities
    })
  end,

  -- Next, you can provide a dedicated handler for specific servers.
  ["lua_ls"] = function(server_name)
    lspconfig[server_name].setup(handlers.lsp_settings[server_name])
  end,

  ["tailwindcss"] = function(server_name)
    lspconfig[server_name].setup(handlers.lsp_settings[server_name])
  end,

})

-- external lsp servers (not installed with mason)
lspconfig.rust_analyzer.setup(handlers.lsp_settings["rust_analyzer"])
-- lspconfig.gopls.setup(handlers.lsp_settings["gopls"])
