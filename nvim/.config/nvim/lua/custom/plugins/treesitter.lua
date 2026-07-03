local M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-context' },
  lazy = false,
  branch = 'main',
  build = ':TSUpdate'
}

M.config = function()
  local ensure_installed = {
    'vim', 'vimdoc', 'regex', 'lua', 'bash',
    'yaml', 'xml', 'json', 'csv', 'sql', 'gitignore',
    'css', 'scss', 'html', 'javascript',
    'typescript', 'tsx', 'jsdoc', 'java',
    'c', 'cpp', 'rust', 'go', 'gomod', 'gosum',
  }
  local treesitter = require('nvim-treesitter')
  treesitter.install(ensure_installed)

  vim.api.nvim_create_autocmd('FileType', {
    callback = function(opt)
      local filetype = opt.match
      local lang = vim.treesitter.language.get_lang(filetype)
      if lang and vim.treesitter.language.add(lang) then
        vim.treesitter.start()
      end
    end
  })

  require('treesitter-context').setup({
    enable = true,
    max_lines = 6,          -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 20, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
  })
  vim.cmd('hi! link TreesitterContextLineNumber CursorLineNr')
end

return M
