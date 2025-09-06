return {
  'folke/snacks.nvim',
  priority = 1000, -- theme.lua is 1000
  lazy = false,
  opts = {
    notifier = { enabled = false },
    explorer = { enabled = false },
    words = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },

    bigfile = { enabled = true },
    quickfile = { enabled = true },
    input = { icon = '' },

    dashboard = {
      enabled = false,
      preset = {
        keys = {
          { icon = '󰻭 ', key = 'e', desc = 'New File', action = ':enew' },
          { icon = '󰱽 ', key = 'b', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = '󱎸 ', key = '/', desc = 'Search Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = '󰊢 ', key = 's', desc = 'Git Status', action = ":lua Snacks.dashboard.pick('git_status')" },
          { icon = '󱀲 ', key = 'o', desc = 'Old Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            hidden = true,
          },
        },
      }
    },

    indent = {
      enabled = true,
      animate = { enabled = false },
      scope = { hl = 'VertSplit' }
    },

    statuscolumn = {
      enabled = true,
      left = { 'sign', --[[ 'mark' ]] }, -- priority of signs on the left (high to low)
      right = { 'fold', 'git' },         -- priority of signs on the right (high to low)
      folds = {
        open = true,                     -- show open fold icons
        git_hl = true,                   -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { 'GitSign' },
      },
      refresh = 50, -- refresh at most every 50ms
    },

    styles = {
      input = {
        backdrop = false,
        position = 'float',
        title_pos = 'center',
        relative = 'cursor',
        border = 'rounded',
        height = 1,
        width = 40,
        row = 1,
        col = 0,
        wo = {
          winhighlight =
              'SnacksInputTitle:Normal,' ..
              'SnacksInputBorder:FloatBorder,',
        },
      },
      dashboard = {
        wo = {
          winhighlight = 'SnacksDashboardHeader:SnacksPickerIdx,'
              .. 'SnacksDashboardKey:@text.strong,',
        },
      }
    },

    zen = {
      toggles = {
        dim = false,
        git_signs = false,
        -- mini_diff_signs = false,
        -- diagnostics = false,
        -- inlay_hints = false,
      },
      show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
      }
    },

    picker = {
      prompt = '   ',
      toggles = {
        follow = 'F',
        hidden = 'H',
        ignored = 'I',
        modified = 'M',
        regex = { icon = 'R', value = false },
      },
      formatters = {
        selected = {
          show_always = false, -- only show the selected column when there are multiple selections
          unselected = false,  -- use the unselected icon for unselected items
        },
      },
      layout = {
        cycle = true,
        preset = function(picker)
          local preferred_layout = {
            files = 'dropdown_centered',
          }
          return preferred_layout[picker] or 'default'
          -- return vim.o.columns >= 120 and 'default' or 'vertical'
        end,
      }
    },

  },
  config = function(_, opts)
    local defaults = require('snacks.picker.config.defaults')
    local layouts = require('snacks.picker.config.layouts')

    defaults.defaults.icons = vim.tbl_deep_extend('keep', {
      ui = {
        follow = 'F',
        hidden = 'H',
        ignored = 'I',
        live = '󰐰 ',
        selected = '󰗠 ',
        unselected = ' '
      },
      diagnostics = {
        Error = '󰅚 ',
        Hint = '󰘥 ',
        Info = ' ',
        Warn = ' '
      },
      git = {
        enabled = true,
        commit = '󰜘 ',
        added = '󰐙',
        modified = '󰐙',
        staged = '󰗡',
        unmerged = '',
        renamed = '󰳠',
        deleted = '󰮈',
        untracked = '󰘥',
        ignored = '󰍷',
      },
    }, defaults.defaults.icons)

    layouts.default = vim.tbl_deep_extend('keep', {
      layout = {
        height = 0.85,
        width = 0.85,
      }
    }, layouts.default)
    layouts.default.layout[2].width = 0.55

    layouts.dropdown_centered = vim.tbl_deep_extend('keep', {
      preview = false,
      layout = {
        height = 0.45,
        row = 0.27,
        width = 0.5,
      }
    }, layouts.dropdown)

    layouts.select = vim.tbl_deep_extend('keep', {
      layout = {
        height = 0.45,
        width = 0.5,
        min_height = 15,
      },
    }, layouts.select)

    require('snacks').setup(opts)
    vim.cmd([[
      hi! link SnacksPickerBorder FloatBorder
      hi! link SnacksPickerPathHidden Text
      hi! Directory guifg=#569cd6 guibg=NONE
    ]])
  end,
  keys = nil
}
