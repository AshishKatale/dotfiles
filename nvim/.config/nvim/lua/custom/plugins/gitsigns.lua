return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = 'BufEnter',
  config = function()
    local gitsigns = require('gitsigns')
    gitsigns.setup({
      signs                        = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        changedelete = { text = '▎' },
        untracked    = { text = '🮌' }, -- ┋
        topdelete    = { text = '▔' },
        delete       = { text = '▁' },

      },
      signs_staged                 = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        changedelete = { text = '▎' },
        untracked    = { text = '🮌' }, -- ┋
        topdelete    = { text = '▔' },
        delete       = { text = '▁' },
      },
      signcolumn                   = true,
      word_diff                    = false,
      current_line_blame           = true,
      watch_gitdir                 = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked          = true,
      current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 300,
        ignore_whitespace = false,
      },
      current_line_blame_formatter =
      '<summary> | <author>, <author_time:%R> | <author_time:%c>',
      sign_priority                = 6,
      update_debounce              = 100,
      status_formatter             = nil, -- Use default
      max_file_length              = 40000,
      preview_config               = {
        -- Options passed to nvim_open_win
        border = 'rounded',
        style = 'minimal',
        row = 1,
        col = 1
      },
    })
    vim.keymap.set({ 'n' }, '<C-p>', gitsigns.prev_hunk, { silent = true })
    vim.keymap.set({ 'n' }, '<C-n>', gitsigns.next_hunk, { silent = true })
  end,
}
