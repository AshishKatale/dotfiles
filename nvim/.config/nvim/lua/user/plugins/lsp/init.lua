local handlers_status_ok, nvim_lsp_configs = pcall(require, "user.plugins.lsp.nvimlsp")
if not handlers_status_ok then
  print("Unable to load: user.plugins.lsp.nvimlsp")
  return
else
  nvim_lsp_configs.setup()
end

local mason_ok, _ = pcall(require, "user.plugins.lsp.mason")
if not mason_ok then
  print("Unable to load: user.plugins.lsp.mason")
  return
end

