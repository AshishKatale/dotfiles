return {
  cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
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
}
