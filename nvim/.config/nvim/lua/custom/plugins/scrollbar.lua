return {
  'petertriho/nvim-scrollbar',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    require('scrollbar').setup({
      show = true,
      show_in_active_only = true,
      set_highlights = true,
      -- handle folds, set to number to disable folds
      -- if no. of lines in buffer exceeds this
      folds = 1000,
      max_lines = false,          -- disables if no. of lines in buffer exceeds
      hide_if_all_visible = true, -- Hides everything if all lines are visible
      throttle_ms = 100,
      handle = {
        text = ' ',
        -- Integer between 0 and 100.
        -- 0 for fully opaque and 100 to full transparent. Defaults to 30.
        blend = 25,
        color = vim.gg.colors.scrollbar,
        color_nr = nil,             -- cterm
        highlight = 'CursorColumn',
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },
      marks = {
        Cursor = {
          text = '-',
          priority = 100,
          gui = nil,
          color = '#999999',
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = 'Normal',
        },
        Error = {
          text = { '' },
          priority = 2,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = 'DiagnosticVirtualTextError',
        },
        Warn = {
          text = { '' },
          priority = 3,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = 'DiagnosticVirtualTextWarn',
        },
        Info = {
          text = { '' },
          priority = 4,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = 'DiagnosticVirtualTextInfo',
        },
        Hint = {
          text = { '' },
          priority = 5,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = 'DiagnosticVirtualTextHint',
        },
        Misc = {
          text = { '-', '=' },
          priority = 6,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = 'Normal',
        },
        GitAdd = {
          text = '▕',
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = 'GitSignsAdd',
        },
        GitChange = {
          text = '▕',
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = 'GitSignsChange',
        },
        GitDelete = {
          text = '▕',
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = 'GitSignsDelete',
        },
      },
      excluded_buftypes = {
        'terminal',
      },
      excluded_filetypes = {
        'prompt',
        'cmp_docs',
        'cmp_menu',
        'NvimTree',
        'TelescopePrompt',
      },
      autocmd = {
        render = {
          'BufWinEnter',
          'TabEnter',
          'TermEnter',
          'WinEnter',
          'CmdwinLeave',
          'TextChanged',
          'VimResized',
          'WinScrolled',
        },
        clear = {
          'BufWinLeave',
          'TabLeave',
          'TermLeave',
          'WinLeave',
        },
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns
        handle = true,
        search = false,  -- Requires hlslens
        ale = false,     -- Requires ALE
      },
    })
  end,
}
