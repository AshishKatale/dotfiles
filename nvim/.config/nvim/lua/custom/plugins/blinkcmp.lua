return {
  'saghen/blink.cmp',
  lazy = true,
  event = 'VeryLazy',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  version = '1.*',

  opts_extend = { 'sources.default' },
  opts = function()
    return {
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
        kind_icons = {
          Text = '󰉨',
          Method = '󰮄',
          Function = '',
          Constructor = '',
          Field = '',
          Variable = '',
          Class = '󰒪',
          Interface = '󱦜',
          Module = '󰅩',
          Property = '',
          Unit = '',
          Keyword = '󱀍',
          Value = '',
          Enum = '',
          EnumMember = '󰖽',
          Snippet = '󰃐',
          Color = '',
          File = '',
          Reference = '',
          Folder = '󰷏',
          Constant = '󰏿',
          Struct = '󱥉',
          Event = '󱐋',
          Operator = '',
          TypeParameter = '󰗴',
        }
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lsp = { name = ' LSP' },
          path = { name = 'PATH' },
          snippets = { name = 'SNIP' },
          buffer = { name = ' BUF' },
          cmdline = { name = ' CMD' },
        },
      },

      keymap = {
        preset = 'default',
        -- show with a list of providers
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-e>'] = {},
        ['<Tab>'] = { 'snippet_forward', 'accept', 'fallback' },
        ['<C-x>'] = { 'hide_documentation', 'show_documentation', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-c>'] = { 'hide', 'fallback' },
        ['<C-space>'] = { 'show', 'fallback' },
      },
      completion = {
        ghost_text = { enabled = false },
        list = {
          selection = { preselect = true, auto_insert = true },
          cycle = { from_bottom = true, from_top = true, },
        },
        menu = {
          max_height = 15,
          border = 'rounded',
          winhighlight = 'CursorLine:BlinkCmpMenuSelection,Search:None',
          draw = {
            columns = { -- kind_icon, kind, label, source_name, source_id
              { 'label',      'label_description' },
              { 'kind_icon' },
              { 'source_name' }
            },
            components = {
              label = {
                width = { fill = true, max = 45 },
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          window = {
            min_width = 20,
            max_width = 100,
            max_height = 24,
            border = 'rounded',
            direction_priority = {
              menu_north = { 'e', 'w', 'n', 's' },
              menu_south = { 'e', 'w', 's', 'n' },
            },
          },
        },
      },

      signature = {
        enabled = true,
        trigger = {
          enabled = true,
          show_on_keyword = true,
          show_on_insert = true,
        },
        window = {
          min_width = 10,
          max_width = 100,
          max_height = 10,
          border = 'rounded',
          winhighlight = 'FloatBorder:FloatBorder',
        }
      },

      -- snippets = { preset = 'luasnip' },

      cmdline = {
        enabled = false,
        completion = {
          menu = {
            auto_show = true,
            draw = { columns = { { 'label' } } }
          },
          list = {
            selection = {
              auto_insert = true,
              preselect = false,
            }
          }
        },
      },
    }
  end,
}
