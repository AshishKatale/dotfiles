local M = {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  priority = 999,
  dependencies = {
    'arkav/lualine-lsp-progress'
  },
}

M.opts = function()
  local colors = vim.gg.colors
  local lsp_progress = {
    'lsp_progress',
    colors = {
      percentage      = colors.info,
      title           = colors.warn,
      message         = colors.info,
      spinner         = colors.hint,
      lsp_client_name = colors.warn,
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
    -- spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏", },
    -- spinner_symbols = { "⣾", "⣻", "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽" },
    spinner_symbols = { '󰪞 ', '󰪟 ', '󰪠 ', '󰪠 ', '󰪢 ', '󰪣 ', '󰪤 ', '󰪥 ' },
  }
  return {
    options = {
      icons_enabled = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'branch',
          icon = { '' },
          color = { fg = colors.info }
        },
        'diff',
        'diagnostics'
      },
      lualine_c = {},
      lualine_x = {
        lsp_progress,
        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = { fg = colors.warn },
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
            snacks_picker_list = 'SnackePicker',
            snacks_picker_input = 'SnacksPicker',
            snacks_picker_preview = 'SnacksPicker',
            Avante = 'Avante',
            AvanteInput = 'Avante',
            AvanteSelectedFiles = 'Avante',
            checkhealth = 'Health',
          },
          symbols = {
            alternate_file = '', -- Text to show to identify the alternate file
            modified = '', -- Text to show when the buffer is modified
          },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'tabs' }
    },
    extensions = {}
  }
end

return M
