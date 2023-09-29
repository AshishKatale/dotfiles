local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
  print("Unable to load: indent_blankline")
  return
end

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

local hooks = require "ibl.hooks"
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

indent_blankline.setup({
  enabled = true,
  indent = {
    char = "▏",
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = false,
    char = "▎",
  },
  whitespace = {
    highlight = {
      "Whitespace", "NonText", "Label", "Function"
    }
  },
})
