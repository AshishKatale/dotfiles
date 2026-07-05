hl.env('XCURSOR_SIZE', '20')
hl.env('HYPRCURSOR_SIZE', '20')
hl.env('HYPRCURSOR_THEME', 'catppuccin-mocha-dark-cursors')
hl.env('XCURSOR_THEME', 'catppuccin-mocha-dark-cursors')

hl.config({
    xwayland = {
        enabled = false,
        force_zero_scaling = true
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        disable_hyprland_guiutils_check = true
    },

    animations = {
        enabled = true,
    }
})

hl.animation({ leaf = 'windows', enabled = true, speed = 2.5, bezier = 'default', style = 'popin' })
hl.animation({ leaf = 'windowsOut', enabled = true, speed = 2.5, bezier = 'default', style = 'popin 80%' })
hl.animation({ leaf = 'layers', enabled = true, speed = 2.5, bezier = 'default', style = 'popin 80%' })

hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd('brightnessctl set 5%+'), { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd('brightnessctl --min-value=5 set 5%-'),
    { locked = true, repeating = true })
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+'),
    { locked = true, repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'),
    { locked = true, repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'),
    { locked = true, repeating = false })
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'),
    { locked = true, repeating = false })
