local M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-context' },
  lazy = true,
  event = 'BufEnter',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
}

M.opts = function()
  return {
    ensure_installed = {
      'vim', 'vimdoc', 'regex', 'lua', 'bash',
      'yaml', 'xml', 'json', 'csv', 'sql', 'gitignore',
      'css', 'scss', 'html', 'javascript',
      'typescript', 'tsx', 'jsdoc', 'java',
      'c', 'cpp', 'rust', 'go', 'gomod', 'gosum',
    },
    sync_install = false,
    ignore_install = { '' }, -- List of parsers to ignore installing
    highlight = {
      enable = true,         -- false will disable the whole extension
      disable = { '' },      -- list of language that will be disabled
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { 'yaml' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'vv',
        node_incremental = 'K',
        scope_incremental = 'L',
        node_decremental = 'J',
      },
    },
  }
end

M.config = function(_, opts)
  require('nvim-treesitter.configs').setup(opts)
  require 'treesitter-context'.setup({
    enable = true,
    min_window_height = 24,
  })
  vim.cmd('hi! link TreesitterContextLineNumber CursorLineNr')
end

return M
