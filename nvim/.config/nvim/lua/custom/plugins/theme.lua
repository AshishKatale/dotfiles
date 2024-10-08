local M = {
  'Mofiqul/vscode.nvim',
  lazy = false,
  priority = 1000,
}

M.opts = function()
  local vscColors = require('vscode.colors').get_colors()
  local color_overrides = vim.tbl_extend('force', vim.gg.colors or {}, {
    vscGitUntracked = '#38E54D',
    scrollbar = '#323232',
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
  vim.api.nvim_create_user_command('OpacityToggle', function()
    local hl = vim.api.nvim_get_hl_by_name('Normal', {})
    if hl.background == nil then
      vim.cmd('hi Normal guifg=#d4d4d4 guibg=#181818')
      vim.cmd('hi NormalFloat guifg=#d4d4d4 guibg=#181818')
      vim.cmd('hi LazyBackdrop guifg=#d4d4d4 guibg=#181818')
      vim.cmd('hi NvimTreeNormal guifg=#d4d4d4 guibg=#1e1e1e')
      vim.cmd('hi LineNr guifg=#5a5a5a guibg=#181818')
      vim.cmd('hi CursorLineNr guibg=#1e1e1e')
      vim.cmd('hi SignColumn guibg=#1e1e1e')
      vim.cmd('hi VertSplit guifg=#444444 guibg=#181818')
      vim.cmd('hi netrwDir guifg=#569cd6 guibg=#1f1f1f')
      vim.cmd('hi! link CurSearch Search')
    else
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
  end, {})

  -- set transparent background on opening neovim
  vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    command = 'OpacityToggle',
  })
end

return M
