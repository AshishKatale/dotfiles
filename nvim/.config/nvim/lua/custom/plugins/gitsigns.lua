return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = 'BufEnter',
  config = function()
    local gitsigns = require('gitsigns')
    gitsigns.setup({
      signs                        = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        changedelete = { text = '┃' },
        untracked    = { text = '┊' }, -- ┋
        topdelete    = { text = '▔' },
        delete       = { text = '▁' },

      },
      signs_staged                 = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        changedelete = { text = '┃' },
        untracked    = { text = '┊' }, -- ┋
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
    require('which-key').add({
      { '<leader>g',  group = 'Git' },
      { '<leader>gp', gitsigns.preview_hunk,        desc = 'Preview hunk' },
      { '<leader>gP', gitsigns.preview_hunk_inline, desc = 'Preview hunk inline' },
      { '<leader>gr', gitsigns.reset_hunk,          desc = 'Reset hunk' },
      { '<leader>gR', gitsigns.reset_buffer,        desc = 'Reset buffer' },
      { '<leader>gG', '<cmd>Gitsigns<cr>',          desc = 'GitSigns menu' },
      { '<leader>gS', gitsigns.stage_hunk,          desc = 'Stage hunk' },
      {
        '<leader>gg',
        require('custom.plugins.utils.fn').lazy_git,
        desc = 'LazyGit'
      },
      {
        '<leader>gB',
        "<cmd>exec \"lua require('gitsigns').blame()\" | wincmd h<cr>",
        desc = 'Blame'
      },
      {
        '<leader>gd',
        "<cmd>exec \"lua require('gitsigns').diffthis()\" | wincmd h<cr>",
        desc = 'File diff'
      },
      {
        '<leader>gf',
        function() require('snacks').picker.git_files() end,
        desc = 'Git Files'
      },
      {
        '<leader>gs',
        function() require('snacks').picker.git_status() end,
        desc = 'Git status'
      },
      {
        '<leader>gb',
        function() require('snacks').picker.git_branches() end,
        desc = 'Branches'
      },
      {
        '<leader>gl',
        function() require('snacks').picker.git_log_line() end,
        desc = 'Git line history'
      },
      {
        '<leader>gc',
        function() require('snacks').picker.git_log() end,
        desc = 'Git commit log'
      },
      {
        '<leader>gh',
        function() require('snacks').picker.git_log_file() end,
        desc = 'File history'
      },

      { '<leader>go', group = 'Browse' },
      {
        '<leader>gob',
        function() require('snacks').gitbrowse.open({ what = 'branch' }) end,
        desc = 'Branch'
      },
      {
        '<leader>goc',
        function() require('snacks').gitbrowse.open({ what = 'commit' }) end,
        desc = 'Commit'
      },
      {
        '<leader>gor',
        function() require('snacks').gitbrowse.open({ what = 'repo' }) end,
        desc = 'Repo'
      },
      {
        '<leader>gof',
        function() require('snacks').gitbrowse.open({ what = 'file' }) end,
        desc = 'File'
      },

      ---@diagnostic disable: param-type-mismatch
      {
        '[g',
        function() gitsigns.nav_hunk('prev') end,
        desc = 'Git hunk previous'
      },
      {
        ']g',
        function() gitsigns.nav_hunk('next') end,
        desc = 'Git hunk next'
      },
      {
        '<C-P>',
        function() gitsigns.nav_hunk('prev') end,
        desc = 'Git hunk previous'
      },
      {
        '<C-N>',
        function() gitsigns.nav_hunk('next') end,
        desc = 'Git hunk next'
      },
    })
  end,
}
