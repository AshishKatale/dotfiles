return {
  'mbbill/undotree',
  lazy = true,
  cmd = { 'UndotreeToggle' },
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicators = 2
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_SplitWidth = 36
    vim.g.undotree_DiffpanelHeight = 18
    vim.g.undotree_TreeVertShape = '│'
    vim.g.undotree_TreeNodeShape = '◉'
    vim.g.undotree_TreeReturnShape = '╱'
    vim.g.undotree_TreeSplitShape = '╱'
  end,
}
