local M = {}
M.lang_servers = {
  lua = 'lua_ls',
  js_ts = 'ts_ls',
  go = 'gopls',
  rust = 'rust_analyzer',
  tailwindcss = 'tailwindcss'
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = vim.tbl_deep_extend(
  'force', capabilities,
  require('blink.cmp').get_lsp_capabilities({}, false)
)

M.ls_settings = {
  [M.lang_servers.lua] = {
    capabilities = M.capabilities,
    settings = {
      Lua = {
        hint = {
          enable = true,
          await = true,
          arrayIndex = 'Auto',
          paramName = 'All',
          paramType = true,
          setType = true,
        },
        workspace = {
          checkThirdParty = false,
        },
      },
      telemetry = {
        enable = false,
      },
    }
  },

  [M.lang_servers.rust] = {
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

  [M.lang_servers.go] = {
    cmd = { 'gopls', 'serve' },
    filetypes = { 'go', 'gomod' },
    capabilities = M.capabilities,
    settings = {
      gopls = {
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        semanticTokens = true,
        analyses = {
          unusedparams = true,
        },
        hints = {
          constantValues = true,
          parameterNames = true,
          rangeVariableTypes = true,
          assignVariableTypes = true,
          compositeLiteralTypes = true,
          compositeLiteralFields = true,
          functionTypeParameters = true
        }
      },
    },
  },

  [M.lang_servers.js_ts] = {
    capabilities = M.capabilities,
    settings = {
      javascript = {
        format = {
          trimtrailingwhitespace = true
        },
        inlayHints = {
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all'
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      typescript = {
        format = {
          trimtrailingwhitespace = true
        },
        inlayHints = {
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all'
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  [M.lang_servers.tailwindcss] = {
    autostart = false
  }
}

return M
