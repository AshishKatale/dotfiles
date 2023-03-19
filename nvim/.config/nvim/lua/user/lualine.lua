local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	print("Unable to load: lualine")
  return
end
return
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
				color = { fg = '#1998FF'},
				icon = {''}
			},
			{
				'diff',
				diff_color = {
					modified = { fg="#1998FF" },
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
			},
			"searchcount",
		},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
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
