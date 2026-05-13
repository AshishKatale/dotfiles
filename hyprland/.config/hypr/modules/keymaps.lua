hl.gesture({
  fingers = 3,
  direction = 'horizontal',
  action = 'workspace'
})

local MOD = 'SUPER' -- Sets "Windows" key as main modifier

hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+'),
  { locked = true, repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'),
  { locked = true, repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'),
  { locked = true, repeating = false })
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'),
  { locked = true, repeating = false })
hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd('brightnessctl set 5%+'), { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd('brightnessctl --min-value=5 set 5%-'),
  { locked = true, repeating = true })

-- Screenshots
hl.bind('PRINT', hl.dsp.exec_cmd('hyprshot -m active -m output'))
hl.bind(MOD .. ' + PRINT', hl.dsp.exec_cmd('hyprshot -m window'))
hl.bind(MOD .. ' + SHIFT + PRINT', hl.dsp.exec_cmd('hyprshot -m region'))
hl.bind(MOD .. ' + SHIFT + S', hl.dsp.exec_cmd('hyprshot -m region --clipboard-only'))

-- Notifications
hl.bind(MOD .. ' + N', hl.dsp.exec_cmd('dunstctl action default'))
hl.bind(MOD .. ' + ALT + N', hl.dsp.exec_cmd('dunstctl history-pop'))
hl.bind(MOD .. ' + CTRL + N', hl.dsp.exec_cmd('dunstctl context'))
hl.bind(MOD .. ' + SHIFT + N', hl.dsp.exec_cmd('dunstctl close-all'))

-- Rofi
hl.bind(MOD .. ' + B', hl.dsp.exec_cmd('pkill rofi || rofi -show drun'))
hl.bind(MOD .. ' + W', hl.dsp.exec_cmd('pkill rofi || rofi -show window -no-show-icons'))

hl.bind(MOD .. ' + RETURN', hl.dsp.exec_cmd('alacritty'))
hl.bind(MOD .. ' + SHIFT + RETURN', hl.dsp.exec_cmd('brave'))
hl.bind(MOD .. ' + SHIFT + C', hl.dsp.exec_cmd('hyprpicker -a'))
hl.bind(MOD .. ' + SHIFT + P', hl.dsp.exec_cmd('pkill -SIGUSR1 waybar'))
hl.bind(MOD .. ' + CTRL + P', hl.dsp.exec_cmd('pkill -SIGUSR2 waybar'))
hl.bind(MOD .. ' + SHIFT + V', hl.dsp.exec_cmd('cliphistmgr'))
hl.bind(MOD .. ' + SHIFT + R', hl.dsp.exec_cmd('hyprctl reload'))
hl.bind(MOD .. ' + SHIFT + Q', hl.dsp.window.close())
hl.bind(MOD .. ' + SHIFT + F', hl.dsp.window.fullscreen())
hl.bind(MOD .. ' + SHIFT + EQUAL', hl.dsp.window.pin())
hl.bind(MOD .. ' + SHIFT + I', hl.dsp.workspace.toggle_special('special'))
hl.bind(MOD .. ' + SHIFT + MINUS', hl.dsp.window.move({ workspace = 'special' }))

hl.bind(MOD .. ' + C', hl.dsp.cursor.move_to_corner({ corner = 1 }))
hl.bind(MOD .. ' + P', hl.dsp.window.pseudo()) -- dwindle
hl.bind(MOD .. ' + E', hl.dsp.layout('togglesplit'))
hl.bind(MOD .. ' + F', function()
  hl.dispatch(hl.dsp.window.float())
  local h = hl.get_active_monitor().height
  local w = hl.get_active_monitor().width
  hl.dispatch(hl.dsp.window.resize({ x = w * 0.5, y = h * 0.5 }))
  hl.dispatch(hl.dsp.window.center())
end)

-- Move window
local function move_win(direction, px)
  if hl.get_active_window().floating then
    local x, y = 0, 0
    if direction == 'l' then
      x = -px
    elseif direction == 'r' then
      x = px
    elseif direction == 'u' then
      y = -px
    elseif direction == 'd' then
      y = px
    end
    hl.dispatch(hl.dsp.window.move({ x = x, y = y, relative = true }))
  else
    hl.dispatch(hl.dsp.window.move({ direction = direction }))
  end
end

hl.bind(MOD .. ' + SHIFT + H', function() move_win('l', 40) end, { repeating = true })
hl.bind(MOD .. ' + SHIFT + L', function() move_win('r', 40) end, { repeating = true })
hl.bind(MOD .. ' + SHIFT + K', function() move_win('u', 40) end, { repeating = true })
hl.bind(MOD .. ' + SHIFT + J', function() move_win('d', 40) end, { repeating = true })

hl.bind(MOD .. ' + SHIFT + LEFT', function() move_win('l', 10) end, { repeating = true })
hl.bind(MOD .. ' + SHIFT + RIGHT', function() move_win('r', 10) end, { repeating = true })
hl.bind(MOD .. ' + SHIFT + UP', function() move_win('u', 10) end, { repeating = true })
hl.bind(MOD .. ' + SHIFT + DOWN', function() move_win('d', 10) end, { repeating = true })

hl.bind(MOD .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true }) -- Left mouse button

-- Window focus
hl.bind(MOD .. ' + TAB', function()
  hl.dispatch(hl.dsp.window.cycle_next())
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = 'top' }))
end)

hl.bind(MOD .. ' + H', function()
  hl.dispatch(hl.dsp.focus({ direction = 'left' }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = 'top' }))
end)
hl.bind(MOD .. ' + L', function()
  hl.dispatch(hl.dsp.focus({ direction = 'right' }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = 'top' }))
end)
hl.bind(MOD .. ' + K', function()
  hl.dispatch(hl.dsp.focus({ direction = 'up' }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = 'top' }))
end)
hl.bind(MOD .. ' + J', function()
  hl.dispatch(hl.dsp.focus({ direction = 'down' }))
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = 'top' }))
end)

-- Workspaces
hl.bind(MOD .. ' + O', hl.dsp.focus({ last = true }))
hl.bind(MOD .. ' + SHIFT + O', hl.dsp.focus({ urgent_or_last = true }))
hl.bind(MOD .. ' + mouse_down', hl.dsp.focus({ workspace = 'e-1' }))
hl.bind(MOD .. ' + mouse_up', hl.dsp.focus({ workspace = 'e+1' }))

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(MOD .. ' + ' .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(MOD .. ' + SHIFT + ' .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(MOD .. ' + CTRL + LEFT', hl.dsp.focus({ monitor = 'left' }))
hl.bind(MOD .. ' + CTRL + RIGHT', hl.dsp.focus({ monitor = 'right' }))
hl.bind(MOD .. ' + SHIFT + LEFT', hl.dsp.focus({ monitor = 'left', follow = true }))
hl.bind(MOD .. ' + RIGHT + LEFT', hl.dsp.focus({ monitor = 'right', follow = true }))

-- Resize window
local resize_submap = 'Resize'
hl.bind(MOD .. ' + SHIFT + R', hl.dsp.submap(resize_submap))
hl.define_submap(resize_submap, function()
  hl.bind('ESCAPE', hl.dsp.submap('reset'))

  hl.bind('L', hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
  hl.bind('H', hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
  hl.bind('K', hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
  hl.bind('J', hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })

  hl.bind(MOD .. ' + L', hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind(MOD .. ' + H', hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind(MOD .. ' + K', hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind(MOD .. ' + J', hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

  hl.bind(MOD .. ' + SHIFT + L', hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind(MOD .. ' + SHIFT + H', hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind(MOD .. ' + SHIFT + K', hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind(MOD .. ' + SHIFT + J', hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
end)
hl.bind(MOD .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true }) -- Right mouse button

-- PowerMenu
local lock_submap = 'PowerMenu:[<i>l</i>]ock-[<i>L</i>]ogout-[<i>r</i>]eboot-[<i>s</i>]hutdown'
hl.bind(MOD .. ' + SHIFT + E', hl.dsp.submap(lock_submap))
hl.define_submap(lock_submap, function()
  hl.bind('ESCAPE', hl.dsp.submap('reset'))

  hl.bind('L', hl.dsp.exec_cmd('hyprlock'))
  hl.bind('R', hl.dsp.exec_cmd('systemctl -q reboot'))
  hl.bind('S', hl.dsp.exec_cmd('systemctl -q poweroff'))
  hl.bind('SHIFT + L',
    hl.dsp.exec_cmd('command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch "hl.dsp.exit()"'))

  hl.bind('L', hl.dsp.submap('reset'))
end)

-- Cursor zoom
local function cursor_zoom(z)
  if z == 0 then
    hl.config({ cursor = { zoom_factor = 1 } })
  else
    local current_zoom = hl.get_config('cursor.zoom_factor')
    local clamped_zoom = math.min(math.max(current_zoom + z, 1), 8)
    hl.config({ cursor = { zoom_factor = clamped_zoom } })
  end
end

local zoom_submap = 'Zoom:[+][-][0]'
hl.bind(MOD .. ' + SHIFT + Z', hl.dsp.submap(zoom_submap))
hl.define_submap(zoom_submap, function()
  hl.bind('ESCAPE', function() cursor_zoom(0) end, { repeating = true })
  hl.bind('ESCAPE', hl.dsp.submap('reset'))

  hl.bind('0', function() cursor_zoom(0) end, { repeating = true })
  hl.bind('MINUS', function() cursor_zoom(-0.1) end, { repeating = true })
  hl.bind('SHIFT + EQUAL', function() cursor_zoom(0.1) end, { repeating = true })

  hl.bind('mouse_up', function() cursor_zoom(-1) end, { mouse = true })
  hl.bind('mouse_down', function() cursor_zoom(1) end, { mouse = true })
  hl.bind('mouse:273', function() cursor_zoom(0) end, { mouse = true }) -- Right mouse button
  hl.bind('mouse:273', hl.dsp.submap('reset'), { mouse = true })        -- Right mouse button
end)
