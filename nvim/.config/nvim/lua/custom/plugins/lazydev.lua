return {
  'folke/lazydev.nvim',
  lazy = true,
  ft = 'lua', -- only load on lua files
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
}
