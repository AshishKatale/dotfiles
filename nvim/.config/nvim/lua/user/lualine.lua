local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	print("Unable to load: lualine")
  return
end

local noice_status_ok, noice = pcall(require, "noice")
if not noice_status_ok then
	print("Unable to load: noice")
  return
end

local c = vim.g.colors
lualine.setup {
  options = {
    icons_enabled = true,
    theme = "vscode",
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
			{
				'branch',
				color = { fg = c.gitSignsBlue },
				icon = {''}
			},
			{
				'diff',
				diff_color = {
					-- modified = { fg = c.gitSignsBlue },
					-- added    = 'DiffAdd',
					-- removed  = 'DiffDelete'
				},
			},
			'diagnostics'
		},
    lualine_c = {
			{
				'filename',
				colored = true,   -- Displays filetype icon in color if set to true
				icon_only = true  -- Display only an icon for filetype
			}
		},
		lualine_x = {
      {
        noice.api.status.mode.get,
        cond = noice.api.status.mode.has,
        color = { fg = "#ff9e64" },
      },
      {
        noice.api.status.search.get,
        cond = noice.api.status.search.has,
        color = { fg = "#ff9e64" },
      },
		},
    lualine_y = {'encoding', 'filetype'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
		lualine_a = {
			{ 'buffers', icons_enabled = true, mode = 0 },
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {'tabs'}
	},
  extensions = {}
}
