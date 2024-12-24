return {
  'lukas-reineke/indent-blankline.nvim',
  lazy = true,
  main = 'ibl',
  event = 'BufEnter *.*',
  config = function()
    local hk = require('ibl.hooks')
    hk.register(hk.type.WHITESPACE, hk.builtin.hide_first_space_indent_level)
    hk.register(hk.type.WHITESPACE, hk.builtin.hide_first_tab_indent_level)

    -- hide indent char in first column for current scope
    -- built in hook not available for current scope
    hk.register(
      hk.type.VIRTUAL_TEXT,
      function(_, _, _, virt_text)
        if virt_text[1] and virt_text[1][1] == '▎' then
          virt_text[1] = { ' ', { '@ibl.whitespace.char.1' } }
        end
        return virt_text
      end
    )

    require('ibl').setup({
      enabled = true,
      indent = {
        char = '▏',
        tab_char = '▏',
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        char = '▎',
        include = {
          -- node_type = { ['*'] = { '*' } },
          node_type = { lua = { 'table_constructor' } },
        }
      },
      whitespace = {
        highlight = {
          'Whitespace', 'Label', 'Function'
        }
      },
    })
  end,
}
