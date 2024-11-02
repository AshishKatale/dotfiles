local M = {
  'Mofiqul/vscode.nvim',
  lazy = false,
  priority = 1000,
}

M.opts = function()
  local vscColors = require('vscode.colors').get_colors()
  local color_overrides = vim.tbl_extend('force', vim.gg.colors or {}, {
    vscGitUntracked = '#38E54D',
    scrollbar = '#323640',
    inlayhint = '#727272',
    info = '#0096FF',
    warn = '#FF9933',
    hint = '#FFFF00',
    error = '#EF233C'
  })
  local colors = vim.tbl_extend('force', vscColors, color_overrides)
  vim.gg.colors = colors;

  return {
    -- style = 'light',
    -- transparent = true,
    terminal_colors = false,
    italic_comments = true,
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides,

    group_overrides = {
      DiffText = { fg = colors.vscFront, bg = colors.vscSelection },
      CursorLine = { bg = colors.scrollbar, },
      ColorColumn = { bg = colors.scrollbar, },
      NvimTreeCursorLine = { bg = colors.scrollbar, },
      NvimTreeGitDeleted = { fg = colors.vscRed, bold = true },
      NvimTreeGitIgnored = { fg = colors.vscRed, },
      NvimTreeFolderIcon = { fg = colors.vscFront, },
      NvimTreeGitNew = { fg = colors.vscGitUntracked, },
      NvimTreeExecFile = { fg = colors.vscGitUntracked, },
      GitSignsAdd = { fg = colors.vscGitUntracked, },
      GitSignsChange = { fg = colors.vscMediumBlue, },
      GitSignsDelete = { fg = colors.vscRed, },
      GitSignsAddPreview = { fg = colors.vscGitUntracked, },
      GitSignsDeletePreview = { fg = colors.vscRed, },
      GitSignsCurrentLineBlame = { fg = colors.vscGray, },
      DiagnosticWarn = { fg = colors.warn, },
      DiagnosticError = { fg = colors.error, },
      DiagnosticInfo = { fg = colors.info, },
      DiagnosticHint = { fg = colors.hint, },
      LspInlayHint = { fg = colors.inlayhint },
      netrwMarkFile = { bg = colors.vscContext }
    }
  }
end

M.config = function(_, opts)
  require('vscode').setup(opts)

  local colorscheme = 'vscode'
  local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
  if not status_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
  end

  if vim.gg.opacity then
    vim.cmd('hi Normal guibg=NONE')
    vim.cmd('hi NormalFloat guibg=NONE')
    vim.cmd('hi LineNr guibg=NONE')
    vim.cmd('hi NvimTreeNormal guibg=NONE')
    vim.cmd('hi CursorLineNr guibg=NONE')
    vim.cmd('hi SignColumn guibg=NONE')
    vim.cmd('hi VertSplit guifg=#666666 guibg=NONE')
    vim.cmd('hi netrwDir guifg=#569cd6 guibg=NONE')
    vim.cmd('hi! link CurSearch Search')
  end
end

return M