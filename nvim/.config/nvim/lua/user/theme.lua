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

vim.cmd("hi rainbowcol1 guifg=#0077FF")
vim.cmd("hi rainbowcol2 guifg=#FF9933")
vim.cmd("hi rainbowcol3 guifg=#9933CC")
vim.cmd("hi rainbowcol4 guifg=#33CCFF")
vim.cmd("hi rainbowcol5 guifg=#FF33FF")
vim.cmd("hi rainbowcol6 guifg=#99FFCC")

vim.api.nvim_create_user_command('ToggleBGOpacity', function()
	local hl = vim.api.nvim_get_hl_by_name("Normal", {})
	if hl.background == nil then
		vim.cmd("hi Normal guifg=#d4d4d4 guibg=#181818")
		vim.cmd("hi NormalFloat guifg=#bbbbbb guibg=#272727")
		vim.cmd("hi NvimTreeNormal guifg=#d4d4d4 guibg=#1e1e1e")
		vim.cmd("hi FocusedWindow guibg=#181818")
		vim.cmd("hi LineNr guifg=#5a5a5a guibg=#181818")
		vim.cmd("hi SignColumn guibg=#1e1e1e")
		vim.cmd("hi MasonNormal guibg=" .. c.masonBG)
		vim.cmd("hi VertSplit guifg=#444444 guibg=#1e1e1e")
	else
		vim.api.nvim_set_hl(0, "Normal", { bg = c.none })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = c.none })
		vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = c.none })
		vim.api.nvim_set_hl(0, "FocusedWindow", { bg = c.none })
		vim.cmd("hi LineNr guibg=" .. c.none)
		vim.cmd("hi SignColumn guibg=" .. c.none)
		vim.cmd("hi MasonNormal guibg=" .. c.masonBG)
		vim.cmd("hi VertSplit guifg=" .. c.gitSignsBlameTextGray .. " guibg=" .. c.none)
	end
end, {})

