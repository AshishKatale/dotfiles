local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	print("Unable to load: nvim-colorizer")
  return
end

colorizer.setup(
	{
		filetypes = { "*" },
		user_default_options = {
			RGB         = true,       -- #RGB hex codes like #FFF
			RRGGBB      = true,       -- #RRGGBB hex codes like #00FF00
			names       = true,       -- "Name" codes like Blue
			RRGGBBAA    = true,       -- #RRGGBBAA hex codes #00FF0088
			rgb_fn      = true,       -- CSS rgb() and rgba() functions like rgb(255, 0, 0) , rgba(255, 0, 0, 0.5)
			hsl_fn      = true,       -- CSS hsl() and hsla() functions like hsl(0, 100%, 50%) , hsla(0, 100%, 50%, 0.5)
			mode        = 'virtualtext', -- Set the display mode.
			virtualtext = "",             -- 
			tailwind    = true,
		}
	}
)

