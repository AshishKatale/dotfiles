return {
  'folke/snacks.nvim',
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  dependencies = { 'nvim-mini/mini.icons' },
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
      enabled = true,
      preset = {
        keys = {
          { icon = '󰻭 ', key = 'n', desc = 'New File', action = ':enew' },
          { icon = '󰱽 ', key = 'b', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files', { hidden = true })" },
          { icon = '󱎸 ', key = 's', desc = 'Search Text', action = ":lua Snacks.dashboard.pick('live_grep', { hidden = true })" },
          { icon = '󰊢 ', key = 'g', desc = 'Git Status', action = ":lua Snacks.dashboard.pick('git_status')" },
          { icon = '󱀲 ', key = 'o', desc = 'Old Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = '󰒲 ', key = 'z', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
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
              .. 'SnacksDashboardFooter:@label,'
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
          unselected = true,   -- use the unselected icon for unselected items
        },
      },
      layout = {
        cycle = true,
        preset = function(picker)
          local preferred_layout = { files = 'dropdown_centered' }
          if preferred_layout[picker] then
            return preferred_layout[picker]
          end
          return vim.o.columns >= 120 and 'default' or 'vertical'
        end,
      },
      actions = {
        toggle_select = function(picker)
          picker.list:select()
        end,
        picker_grep_prompt = function(_, item)
          if item then
            local cwd = require('snacks').picker.util.dir(item)
            require('snacks').picker.grep({
              cwd = cwd,
              hidden = true,
              title = ' Grep [' .. vim.fn.fnamemodify(cwd, ':t') .. '] ',
            })
          end
        end
      }
    },

  },
  config = function(_, opts)
    local defaults = require('snacks.picker.config.defaults').defaults
    local sources = require('snacks.picker.config.sources')
    local layouts = require('snacks.picker.config.layouts')

    defaults.icons = vim.tbl_deep_extend('keep', {
      ui = {
        follow = 'F',
        hidden = 'H',
        ignored = 'I',
        live = '󰐰',
        selected = '   ',
        unselected = '   '
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
      tree = {
        last = '└╴',
        middle = '├╴',
        vertical = '┆ '
      },
    }, defaults.icons)

    defaults.win = vim.tbl_deep_extend('keep', {
        input = {
          keys = {
            ['j'] = 'toggle_focus',
            ['k'] = 'focus_preview',
            ['<c-c>'] = { 'cancel', mode = { 'i', 'n' } },
            ['<c-o>'] = { 'toggle_select', mode = { 'i', 'n' } },
            ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['<c-f>'] = { 'list_scroll_down', mode = { 'i', 'n' } },
            ['<c-b>'] = { 'list_scroll_up', mode = { 'i', 'n' } },
            ['<a-p>'] = { 'history_back', mode = { 'i', 'n' } },
            ['<a-n>'] = { 'history_forward', mode = { 'i', 'n' } },
            ['<c-x>'] = { 'edit_split', mode = { 'i', 'n' } },
            ['<c-a-p>'] = { 'toggle_preview', mode = { 'i', 'n' } },
          }
        },
        list = {
          keys = {
            ['<c-c>'] = 'cancel',
            ['<c-o>'] = 'toggle_select',
            ['<c-d>'] = 'preview_scroll_down',
            ['<c-u>'] = 'preview_scroll_up',
            ['<c-f>'] = 'list_scroll_down',
            ['<c-b>'] = 'list_scroll_up',
            ['<c-x>'] = 'edit_split',
            ['<c-a-p>'] = 'toggle_preview',
          },
          wo = {
            scrolloff = 2,
          },
        },
        preview = {
          keys = {
            ['<c-c>'] = 'cancel',
            ['<a-m>'] = 'toggle_maximize',
            ['<c-a-p>'] = 'toggle_preview'
          },
        },
      },
      defaults.win);

    sources.explorer = vim.tbl_deep_extend('keep', {
      auto_close = true,
      hidden = true,
      git_status = true,
      git_status_open = true,
      layout = {
        preset = 'right',
        preview = false,
        layout = { width = 0.275 },
      },
      win = {
        list = {
          keys = {
            ['-'] = 'explorer_up',
            ['='] = 'explorer_focus',
            ['n'] = 'explorer_add',
            ['w'] = 'explorer_close_all',
            ['/'] = 'picker_grep_prompt',
            ['<c-c>'] = 'close',
            ['<c-l>'] = 'explorer_update',
          },
        },
      },
    }, sources.explorer);

    layouts.default = vim.tbl_deep_extend('keep', {
      layout = {
        height = 0.85,
        width = 0.85,
      }
    }, layouts.default)
    layouts.default.layout[2].width = 0.55 -- preview width

    layouts.dropdown_centered = vim.tbl_deep_extend('keep', {
      preview = false,
      layout = {
        height = 0.4,
        row = 0.3,
        width = 0.5,
      }
    }, layouts.dropdown)

    layouts.select = vim.tbl_deep_extend('keep', {
      layout = {
        width = 0.5,
        max_height = 15,
      },
    }, layouts.select)

    require('snacks').setup(opts)
    vim.cmd([[
      hi! link SnacksPickerBorder FloatBorder
      hi! link SnacksPickerDimmed LspInlayHint
      hi! link SnacksPickerPathHidden SnacksPickerFile
      hi! SnacksPickerMatch guifg=#18a2fe gui=bold
      hi! SnacksPickerGitBranch guifg=#d7ba7d gui=bold
      hi! Directory guifg=#569cd6 guibg=NONE
    ]])
  end,
  keys = nil
}
