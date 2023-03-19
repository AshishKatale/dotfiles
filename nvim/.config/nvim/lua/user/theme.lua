local colorscheme = "vscode"

require('vscode').setup({
    -- style = 'light'

    -- Enable transparent background
    -- transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    -- color_overrides = {
    --     vscLineNumber = '#FFFFFF',
    -- },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    -- group_overrides = {
    --     -- this supports the same val table as vim.api.nvim_set_hl
    --     -- use colors from this colorscheme by requiring vscode.colors!
    --     Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    -- }
})
 
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- local colors = require('vscode.colors').get_colors()

-- override highlight colors
vim.cmd("hi CursorLine guifg=none guibg=#323232") -- override cursorline bg color of vscode theme

vim.cmd("hi GitSignsChange guifg=#0096FF")

vim.cmd("hi GitSignsAdd guifg=#38E54D")
vim.cmd("hi GitSignsDelete guifg=#EF233C")
vim.cmd("hi GitSignsAddPreview guifg=#38E54D")
vim.cmd("hi GitSignsDeletePreview  guifg=#EF233C")
vim.cmd("hi GitSignsCurrentLineBlame guifg=#707070")

vim.cmd("hi NvimTreeCursorLine guibg=#323232")
vim.cmd("hi NvimTreeGitNew guifg=#38E54D")
vim.cmd("hi NvimTreeGitDeleted guifg=#EF233C")
vim.cmd("hi NvimTreeGitIgnored guifg=#EF233C")
vim.cmd("hi NvimTreeFolderIcon guifg=#bcbcbc")
vim.cmd("hi NvimTreeExecFile gui=bold guifg=#38E54D")

vim.cmd("hi rainbowcol1 guifg=#0077FF")
vim.cmd("hi rainbowcol2 guifg=#FF9933")
vim.cmd("hi rainbowcol3 guifg=#9933CC")
vim.cmd("hi rainbowcol4 guifg=#33CCFF")
vim.cmd("hi rainbowcol5 guifg=#FF33FF")
vim.cmd("hi rainbowcol6 guifg=#99FFCC")

