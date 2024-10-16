return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  config = function()
    require('dressing').setup({
      input = {
        override = function(conf)
          if ' New Name ' == conf.title then
            -- customize LSP rename popup
            return vim.tbl_extend('force', conf, {
              col = 0,
              row = 0,
              relative = 'cursor',
              title = ' Rename to '
            })
          elseif ' Rename to ' == conf.title then
            -- customize nvimtree rename popup
            local cur_row = vim.api.nvim_win_get_cursor(0)[1]
            vim.api.nvim_win_set_cursor(0, { cur_row, 0 })
            return vim.tbl_extend('force', conf, {
              col = 0,
              row = 2,
              anchor = 'SE',
              relative = 'cursor',
            })
          end
        end,
        relative = 'editor',
        win_options = {
          -- Window transparency (0-100)
          winblend = 0,
          -- Disable line wrapping
          wrap = false,
        },
        mappings = {
          n = {
            ['<Esc>'] = 'Close',
            ['<C-c>'] = 'Close',
            ['<CR>'] = 'Confirm',
          },
          i = {
            ['<C-c>'] = 'Close',
            ['<CR>'] = 'Confirm',
            ['<Up>'] = 'HistoryPrev',
            ['<Down>'] = 'HistoryNext',
          },
        },
      }
    })
  end
}
