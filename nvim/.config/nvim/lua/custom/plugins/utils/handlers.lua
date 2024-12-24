local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  vim.notify('Unable to load: cmp_nvim_lsp')
  return
end

local ls = {
  lua = 'lua_ls',
  go = 'gopls',
  rust = 'rust_analyzer',
  tailwindcss = 'tailwindcss'
}

local M = {}

M.ls = ls
M.capabilities = cmp_nvim_lsp.default_capabilities()

M.lsp_settings = {
  [ls.lua] = {
    capabilities = M.capabilities,
    settings = {
      Lua = {
        runtime = { version = 'Lua 5.1' },
        diagnostics = {
          globals = { 'vim' },
        },
      },
      telemetry = {
        enable = false,
      },
    }
  },

  [ls.rust] = {
    cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
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

  [ls.go] = {
    cmd = { 'gopls', 'serve' },
    filetypes = { 'go', 'gomod' },
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

  [ls.tailwindcss] = {
    autostart = false
  }
}

return M
