return {
  'lukas-reineke/indent-blankline.nvim',
  lazy = true,
  main = 'ibl',
  event = 'BufEnter *.*',
  config = function()
    local hk = require('ibl.hooks')
    hk.register(hk.type.WHITESPACE, hk.builtin.hide_first_space_indent_level)
    hk.register(hk.type.WHITESPACE, hk.builtin.hide_first_tab_indent_level)
    require('ibl').setup({
      enabled = true,
      indent = {
        char = '▏',
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        char = '▎',
      },
      whitespace = {
        highlight = {
          'Whitespace', 'Label', 'Function'
        }
      },
    })
  end,
}
