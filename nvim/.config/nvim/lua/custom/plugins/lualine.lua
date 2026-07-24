local M = {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  enabled = function()
    return vim.env.NVIM_NO_LUALINE ~= '1'
  end,
  priority = 999,
  dependencies = {
    'arkav/lualine-lsp-progress'
  },
}

M.opts = function()
  local lsp_progress = {
    'lsp_progress',
    colors = {
      percentage      = '#18A2FE',
      title           = '#F28B25',
      message         = '#18A2FE',
      spinner         = '#FFD602',
      lsp_client_name = '#F28B25',
      use             = true,
    },
    display_components = {
      { 'title', 'percentage' },
      'lsp_client_name',
      'spinner'
    },
    timer = {
      progress_enddelay = 100,
      spinner = 300,
      lsp_client_name_enddelay = 300
    },
    spinner_symbols = { '󰪞 ', '󰪟 ', '󰪠 ', '󰪠 ', '󰪢 ', '󰪣 ', '󰪤 ', '󰪥 ' },
  }

  -- override theme colors
  local lualine_theme = vim.tbl_deep_extend('force', require 'lualine.themes.auto', {
    command = {
      a = { bg = '#008701', fg = '#181825' },
      b = { bg = '#373737', fg = '#18A1FD' },
    },
    inactive = {
      a = { bg = '#373737', fg = '#18A1FD' },
      b = { bg = '#373737', fg = '#18A1FD' },
    },
    insert = {
      a = { bg = '#179299', fg = '#181825' },
      b = { bg = '#373737', fg = '#18A1FD' },
    },
    normal = {
      a = { bg = '#0A7ACA', fg = '#181825' },
      b = { bg = '#373737', fg = '#18A1FD' },
    },
    replace = {
      a = { bg = '#AF0000', fg = '#181825' },
      b = { bg = '#373737', fg = '#18A1FD' },
    },
    terminal = {
      a = { bg = '#00AF50', fg = '#181825' },
      b = { bg = '#373737', fg = '#18A1FD' },
    },
    visual = {
      a = { bg = '#CA6702', fg = '#181825' },
      b = { bg = '#373737', fg = '#18A1FD' },
    }
  })

  return {
    options = {
      icons_enabled        = true,
      theme                = lualine_theme,
      component_separators = { left = '', right = '' },
      section_separators   = { left = '', right = '' },
      disabled_filetypes   = { 'lazygit' }, -- List of filetypes to hide statusline
      always_divide_middle = true,
      globalstatus         = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        { 'branch', icon = { '' } },
        'diff',
        'diagnostics',
      },
      lualine_c = {},
      lualine_x = {
        lsp_progress,
        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = { fg = "#F28B25" },
        },
      },
      lualine_y = { 'encoding', 'filetype', 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {
      lualine_a = {
        {
          'buffers',
          icons_enabled = false,
          mode = 0,
          filetype_names = {
            snacks_dashboard = 'Dashboard',
            snacks_input = 'Input',
            snacks_picker_list = 'SnacksPicker',
            snacks_picker_input = 'SnacksPicker',
            snacks_picker_preview = 'SnacksPicker',
            Avante = 'Avante',
            AvanteInput = 'Avante',
            AvanteSelectedFiles = 'Avante',
            checkhealth = 'Health',
          },
          symbols = {
            alternate_file = '', -- Text to show to identify the alternate file
            modified = ' ⦿', -- Text to show when the buffer is modified
          },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'tabs' }
    },
    extensions = { 'lazy', 'quickfix', 'trouble', 'man', 'mason' }
  }
end

M.config = function(_, opts)
  require('lualine').setup(opts)
  local lazy = require('lualine.extensions.lazy').sections;
  lazy.lualine_a = { function() return 'Lazy 󰒲' end }
end

return M
