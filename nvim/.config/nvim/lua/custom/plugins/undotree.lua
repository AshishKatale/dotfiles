return {
  'mbbill/undotree',
  lazy = true,
  cmd = { 'UndotreeToggle' },
  config = function()
    vim.g.undotree_WindowLayout       = 2
    vim.g.undotree_ShortIndicators    = 1
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_SplitWidth         = 36
    vim.g.undotree_DiffpanelHeight    = 16
    vim.g.undotree_TreeNodeShape      = '◉'
    vim.g.undotree_TreeReturnShape    = '╲'
    vim.g.undotree_TreeVertShape      = '│'
    vim.g.undotree_TreeSplitShape     = '╱'

    -- vim.cmd [[
    --     hi! UndotreeNode guifg=#569CD6 guibg=NONE
    --     hi! UndotreeSavedBig guifg=#4EC9B0 guibg=NONE gui=bold
    --     hi! UndotreeSavedSmall guifg=#B5CEA8 guibg=NONE
    -- ]]
  end,
}
