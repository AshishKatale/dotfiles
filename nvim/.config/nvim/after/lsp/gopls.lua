return {
  cmd = { 'gopls', 'serve' },
  filetypes = { 'go', 'gomod' },
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
}
