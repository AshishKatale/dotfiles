local M = {
  'Mofiqul/vscode.nvim',
  lazy = false,
  priority = 1001,
}

M.opts = function()
  local vscColors = require('vscode.colors').get_colors()
  local color_overrides = vim.tbl_extend('force', vim.gg.colors or {}, {
    cursorline = '#323640',
    vscGitUntracked = '#38E54D',
    gitUntracked = '#38E54D',
    gitChanged = vscColors.vscMediumBlue,
    gitDeleted = vscColors.vscRed,
    inlayhint = vscColors.vscGray,
    info = vscColors.vscBlue,
    warn = vscColors.vscUiOrange,
    hint = vscColors.vscDarkYellow,
    error = vscColors.vscRed
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
      CursorLine = { bg = colors.cursorline, },
      ColorColumn = { bg = colors.cursorline, },
      QuickFixLine = { bg = colors.cursorline, bold = true },
      NvimTreeCursorLine = { bg = colors.cursorline, },
      NvimTreeGitDeleted = { fg = colors.vscRed, bold = true },
      NvimTreeGitIgnored = { fg = colors.vscRed, },
      NvimTreeFolderIcon = { fg = colors.vscFront, },
      NvimTreeGitNew = { fg = colors.gitUntracked, },
      NvimTreeExecFile = { fg = colors.gitUntracked, },
      GitSignsAdd = { fg = colors.gitUntracked, },
      GitSignsChange = { fg = colors.gitChanged, },
      GitSignsDelete = { fg = colors.gitDeleted, },
      GitSignsAddPreview = { fg = colors.gitUntracked, },
      GitSignsDeletePreview = { fg = colors.vscRed, },
      GitSignsCurrentLineBlame = { fg = colors.vscGray, },
      DiagnosticWarn = { fg = colors.vscUiOrange, },
      DiagnosticError = { fg = colors.vscRed, },
      DiagnosticInfo = { fg = colors.vscBlue, },
      DiagnosticHint = { fg = colors.vscDarkYellow, },
      LspInlayHint = { fg = colors.inlayhint },
      netrwMarkFile = { bg = colors.vscContext },
      Folded = {
        fg = colors.vscBlueGreen,
        bg = colors.vscDarkBlue,
        bold = true,
        italic = true,
      },
    }
  }
end

M.config = function(_, opts)
  require('vscode').setup(opts)

  local colorscheme = 'vscode'
  local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
  if not status_ok then
    vim.api.nvim_echo(
      { { 'Error: colorscheme ' .. colorscheme .. ' not found!' } },
      false, -- don't add to message history
      { err = true }
    )
    return
  end

  if vim.gg.opacity then
    vim.cmd([[
      hi Normal guibg=NONE
      hi LineNr guibg=NONE
      hi NvimTreeNormal guibg=NONE
      hi CursorLineNr guibg=NONE
      hi SignColumn guibg=NONE
      hi netrwDir guifg=#569CD6 guibg=NONE
      hi VertSplit guifg=#777777 guibg=NONE
      hi PmenuThumb guifg=NONE guibg=#777777
      hi! link NormalFloat Normal
      hi! link CurSearch Search
      hi! link FloatBorder VertSplit
    ]])
  end
end

return M
