local M = {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  enabled = function()
    return vim.env.NVIM_NO_LUALINE ~= '1'
  end,
  priority = 999,
  dependencies = {
    {
      'linrongbin16/lsp-progress.nvim',
      config = function()
        require('lsp-progress').setup({
          max_size = 80,
          spin_update_time = 250,
          event = 'LspProgressUpdate',
          spinner = { '󰪞 ', '󰪟 ', '󰪠 ', '󰪠 ', '󰪢 ', '󰪣 ', '󰪤 ', '󰪥 ' },
          series_format = function(title, message, percentage, _done)
            local builder = {}
            local has_title = false
            local has_message = false
            if type(title) == 'string' and string.len(title) > 0 then
              table.insert(builder, title)
              has_title = true
            end
            if type(message) == 'string' and string.len(message) > 0 then
              table.insert(builder, message)
              has_message = true
            end
            if percentage and (has_title or has_message) then
              table.insert(builder, string.format('{} %.0f%% ', percentage)) -- keep {} as placeholder
            end
            return table.concat(builder, ' ')
          end,
          client_format = function(client_name, spinner, series_messages)
            if #series_messages > 0 then
              return series_messages[1]:gsub('{}', '[' .. client_name .. ']') .. spinner -- replace {} with server name
            end
          end,
          format = function(client_messages)
            return client_messages[#client_messages] or ''
          end,
        })
        vim.api.nvim_create_autocmd('User', {
          pattern = 'LspProgressUpdate',
          callback = function() require('lualine').refresh() end,
          group = vim.api.nvim_create_augroup('lualine_augroup', { clear = true }),
        })
      end
    }
  },
}

M.opts = function()
  -- override theme colors
  local lualine_theme = vim.tbl_deep_extend('force', require 'lualine.themes.auto', {
    normal = {
      a = { bg = '#0A7ACA', fg = '#11111E' },
      b = { bg = '#373737', fg = '#18A1FD' },
      z = { bg = '#0A7ACA', fg = '#11111E', gui = 'bold' },
    },
    insert = {
      a = { bg = '#479077', fg = '#11111E' },
      b = { bg = '#373737', fg = '#18A1FD' },
      z = { bg = '#0A7ACA', fg = '#11111E', gui = 'bold' },
    },
    command = {
      a = { bg = '#1A801A', fg = '#11111E' },
      b = { bg = '#373737', fg = '#18A1FD' },
      z = { bg = '#0A7ACA', fg = '#11111E', gui = 'bold' },
    },
    visual = {
      a = { bg = '#CA6702', fg = '#11111E' },
      b = { bg = '#373737', fg = '#18A1FD' },
      z = { bg = '#0A7ACA', fg = '#11111E', gui = 'bold' },
    },
    replace = {
      a = { bg = '#AF0000', fg = '#11111E' },
      b = { bg = '#373737', fg = '#18A1FD' },
      z = { bg = '#0A7ACA', fg = '#11111E', gui = 'bold' },
    },
    terminal = {
      a = { bg = '#479077', fg = '#11111E' },
      b = { bg = '#373737', fg = '#18A1FD' },
      z = { bg = '#0A7ACA', fg = '#11111E', gui = 'bold' },
    },
    inactive = {
      a = { bg = '#373737', fg = '#18A1FD' },
      b = { bg = '#373737', fg = '#18A1FD' },
      z = { bg = '#0A7ACA', fg = '#11111E', gui = 'bold' },
    },
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
        { 'branch', icon = { '' }, color = { gui = 'bold' } },
        'diff',
        'diagnostics',
      },
      lualine_c = {},
      lualine_x = {
        {
          function() return require('lsp-progress').progress() end,
          color = { fg = '#F28B25' }
        },
        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = { fg = '#F28B25' },
        },
      },
      lualine_y = {
        function()
          local lsps = #vim.lsp.get_clients({ bufnr = 0 })
          return lsps > 0 and ' ' .. lsps or ''
        end,
        'encoding', 'filetype', 'progress'
      },
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
