hl.config({
  animations = {
    enabled = true
  },
})

hl.curve('easeInOutSine', { type = 'bezier', points = { { 0.45, 0.05 }, { 0.55, 0.95 } } })

hl.animation({ leaf = 'windows', enabled = true, speed = 2.5, bezier = 'default' })
hl.animation({ leaf = 'windowsOut', enabled = true, speed = 2.5, bezier = 'default', style = 'popin 80%' })
hl.animation({ leaf = 'fade', enabled = true, speed = 2, bezier = 'default' })
hl.animation({ leaf = 'workspaces', enabled = true, speed = 2.5, bezier = 'default' })
hl.animation({ leaf = 'layers', enabled = true, speed = 1.5, bezier = 'easeInOutSine', style = 'slide' })
hl.animation({ leaf = 'specialWorkspace', enabled = true, speed = 2.5, bezier = 'easeInOutSine', style = 'slide' })
hl.animation({ leaf = 'zoomFactor', enabled = true, speed = 2.5, bezier = 'default' })
hl.animation({ leaf = 'border', enabled = false })
hl.animation({ leaf = 'borderangle', enabled = false })
