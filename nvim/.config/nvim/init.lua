local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4

vim.gg = {
  opacity = true
}

local opts = {
  ui = {
    size = { width = 0.85, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    border = 'rounded',
    icons = {
      cmd = ' ',
      config = '',
      event = '',
      ft = ' ',
      init = ' ',
      import = ' ',
      keys = ' ',
      lazy = '󰒲 ',
      loaded = '●',
      not_loaded = '○',
      plugin = ' ',
      runtime = ' ',
      source = ' ',
      start = '',
      task = '✔ ',
      list = {
        '●',
        '➜',
        '★',
        '-',
      },
    },
  },
  dev = {
    path = '~/workspace/nvim',
    patterns = {},
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
}

require('lazy').setup('custom/plugins', opts)
