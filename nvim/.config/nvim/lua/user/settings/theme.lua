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

local vscColors = require('vscode.colors').get_colors()
local c = {
	none = "NONE",
	info = "#0096FF",
	warn = "#FF9933",
	hint = "#FFFF00",
	error = "#EF233C",
	cursorlineGray = "#323232",
	gitSignsBlue = "#0096FF",
	gitSignsGreen = "#38E54D",
	gitSignsRed = "#EF233C",
	gitSignsBlameTextGray = "#777777",
	nvimTreeIconColor = "#BCBCBC",
	masonBG = "#0b001d"
}
c = vim.tbl_extend('force', vscColors, c)
vim.g.colors = c;

-- override highlight colors
vim.cmd("hi CursorLine guifg=none guibg=" .. c.cursorlineGray) -- override cursorline bg color of vscode theme

vim.cmd("hi GitSignsChange guifg=" .. c.gitSignsBlue)
vim.cmd("hi GitSignsAdd guifg=" .. c.gitSignsGreen)
vim.cmd("hi GitSignsDelete guifg=" .. c.gitSignsRed)
vim.cmd("hi GitSignsAddPreview guifg=" .. c.gitSignsGreen)
vim.cmd("hi GitSignsDeletePreview  guifg=" .. c.gitSignsRed)
vim.cmd("hi GitSignsCurrentLineBlame guifg=" .. c.gitSignsBlameTextGray)

vim.cmd("hi DiagnosticWarn guifg=" .. c.warn)
vim.cmd("hi DiagnosticError guifg=" .. c.error)
vim.cmd("hi DiagnosticInfo guifg=" .. c.info)
vim.cmd("hi DiagnosticHint guifg=" .. c.hint)

vim.cmd("hi NvimTreeCursorLine guibg=" .. c.cursorlineGray)
vim.cmd("hi NvimTreeGitNew guifg=" .. c.gitSignsGreen)
vim.cmd("hi NvimTreeGitDeleted guifg=" .. c.gitSignsRed)
vim.cmd("hi NvimTreeGitIgnored guifg=" .. c.gitSignsRed)
vim.cmd("hi NvimTreeFolderIcon guifg=" .. c.nvimTreeIconColor)
vim.cmd("hi NvimTreeExecFile gui=bold guifg=" .. c.gitSignsGreen)

