return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    notifier = { enabled = false },
    explorer = { enabled = false },
    picker = { enabled = false },
    words = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },

    dashboard = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    input = { icon = '' },

    indent = {
      enabled = true,
      animate = { enabled = false },
      scope = { hl = 'VertSplit' }
    },

    statuscolumn = {
      left = { 'sign' },         -- priority of signs on the left (high to low)
      right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
      folds = {
        open = true,             -- show open fold icons
        git_hl = false,          -- use Git Signs hl for fold icons
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
      },
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
    }

  },
  config = function(_, opts)
    require('snacks').setup(opts)
    vim.cmd([[
      hi! link SnacksPickerBorder FloatBorder
      hi! link SnacksInputTitle Normal
      hi! link SnacksInputBorder FloatBorder
    ]])
  end,
  keys = nil
}
