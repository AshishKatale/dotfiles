return {
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
      diagnostics = {
        unusedLocalExclude = { '_*' },
      },
    },
    telemetry = {
      enable = false,
    },
  }
}
