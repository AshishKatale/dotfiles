return {
  'mbbill/undotree',
  lazy = true,
  cmd = { 'UndotreeToggle' },
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicators = 2
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
