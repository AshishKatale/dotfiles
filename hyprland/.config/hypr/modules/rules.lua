local overlayLayerRule = hl.layer_rule({
  name      = 'wallpaper-overlay-swaybg',
  match     = { namespace = 'wallpaper' },
  animation = 'popin 80%'
})
overlayLayerRule:set_enabled(true)

hl.workspace_rule({
  workspace = 'special:special',
  on_created_empty =
  '[float; size (monitor_w*0.75) (monitor_h*0.75)] alacritty'
})

hl.window_rule({
  -- Ignore maximize requests from all apps.
  name           = 'suppress-maximize-events',
  match          = { class = '.*' },
  suppress_event = 'maximize',
})

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = 'fix-xwayland-dragging',
  match    = {
    class      = '^$',
    title      = '^$',
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

hl.window_rule({ match = { float = false, workspace = 'w[tv1]s[false]' }, border_size = 0 })
hl.window_rule({ match = { pin = true }, border_color = 'rgba(005A9CEE)' })
hl.window_rule({ match = { workspace = 's[true]' }, border_color = 'rgba(5D9FBDEE)' })

hl.window_rule({
  match = { title = '^(DevTools|Save File|.*wants to save|Open File|.*wants to open)$' },
  float = true,
  center = true,
  size = { '(monitor_w*0.75)', '(monitor_h*0.75)' }
})

hl.window_rule({
  match = { initial_title = '^$', initial_class = 'firefox' },
  float = true,
  center = true,
  size = { '(monitor_w*0.75)', '(monitor_h*0.75)' }
})

hl.window_rule({
  match = { initial_class = '^(nm-.*)$' },
  float = true,
  center = true,
  size = { '(monitor_w*0.5)', '(monitor_h*0.5)' }
})

hl.window_rule({
  match = { initial_class = 'hyprland-share-picker' },
  float = true,
  center = true,
  size = { '(monitor_w*0.5)', '(monitor_h*0.5)' }
})
