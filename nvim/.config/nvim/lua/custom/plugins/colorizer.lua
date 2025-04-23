return {
  'catgoose/nvim-colorizer.lua',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    require('colorizer').setup(
      {
        filetypes = { '*' },
        user_default_options = {
          RGB         = true, -- #RGB hex codes like #FFF
          RRGGBB      = true, -- #RRGGBB hex codes like #00FF00
          names       = false, -- "Name" codes like Blue
          RRGGBBAA    = true, -- #RRGGBBAA hex codes #00FF0088
          rgb_fn      = true, -- CSS rgb() and rgba()
          hsl_fn      = true, -- CSS hsl() and hsla()
          mode        = 'virtualtext', -- Set the display mode.
          virtualtext = '󰚍', --  󰝤  󰚍
          tailwind    = true,
        }
      }
    )
  end,
}
