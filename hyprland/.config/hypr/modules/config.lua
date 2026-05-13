hl.config({
  general = {
    gaps_in = 1,
    gaps_out = 1,
    border_size = 2,
    resize_on_border = false,
    col = {
      active_border = 'rgba(777777EE)',
      inactive_border = 'rgba(333333AA)',
    },
  },

  input = {
    kb_layout = 'us',
    repeat_rate = 50,
    repeat_delay = 300,
    follow_mouse = 1,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.5,
      drag_lock = 0,
    },

    sensitivity = 0 -- -1.0 - 1.0, 0 means no modification.
  },

  decoration = {
    rounding = 4,
    rounding_power = 2,

    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
      color = 'rgba(1a1a1aee)',
    },

    blur = {
      enabled = true,
      size = 5,
      passes = 1,
      vibrancy = 0.1696,
    }
  },

  dwindle = {
    preserve_split = true,
    force_split = 2,
  },

  master = {
    new_status = 'slave',
    orientation = 'left',
  },

  xwayland = {
    enabled = true,
    force_zero_scaling = true
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    disable_hyprland_guiutils_check = true
  },

  binds = {
    drag_threshold = 10
  },
})

