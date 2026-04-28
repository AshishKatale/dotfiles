return {
  'rmagatti/gx-extended.nvim',
  keys = { 'gx' },
  event = 'BufEnter',
  config = function()
    require('gx-extended').setup({})
  end
}
