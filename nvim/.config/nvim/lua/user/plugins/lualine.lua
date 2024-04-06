local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  print("Unable to load: lualine")
  return
end

local colors = vim.g.colors
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
  display_components = { { 'message', 'percentage' }, 'lsp_client_name', 'spinner' },
  timer = { progress_enddelay = 100, spinner = 300, lsp_client_name_enddelay = 300 },
  -- spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏", },
  -- spinner_symbols = { "⣾", "⣻", "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽" },
  spinner_symbols = { "󰪞 ", "󰪟 ", "󰪠 ", "󰪠 ", "󰪢 ", "󰪣 ", "󰪤 ", "󰪥 " },
}

lualine.setup {
  options = {
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
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
        require("lazy.status").updates,
        cond = require("lazy.status").has_updates,
        color = { fg = "#ff9e64" },
      },
    },
    lualine_y = { 'encoding', 'filetype', "progress" },
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
        icons_enabled = true,
        mode = 0,
        symbols = {
          alternate_file = '', -- Text to show to identify the alternate file
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
