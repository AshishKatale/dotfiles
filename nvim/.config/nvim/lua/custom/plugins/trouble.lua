return {
  'folke/trouble.nvim',
  lazy = true,
  cmd = 'Trouble',
  config = function()
    require('trouble').setup({
      auto_preview = true,     -- automatically open preview when on an item
      auto_refresh = false,    -- auto refresh when open
      auto_jump = false,       -- auto jump to the item when there's only one
      focus = true,            -- Focus the window when opened
      restore = true,          -- restore last location in the list when opening
      follow = true,           -- Follow the current item
      indent_guides = true,    -- show indent guides
      max_items = 200,         -- limit number of items per section
      multiline = false,       -- render multi-line messages
      pinned = false,          -- bind open trouble window to the current buffer
      warn_no_results = true,  -- show a warning when there are no results
      open_no_results = false, -- open the trouble window when no results

      -- Window options for the preview window. Can be a split, floating window,
      -- or `main` to show the preview in the main editor window.
      preview = {
        type = 'main',
        -- when a buffer is not yet loaded, the preview window will be created
        -- in a scratch buffer with only syntax highlighting enabled.
        -- Set to false, for preview to always be a real loaded buffer.
        scratch = true,
      },

      -- Throttle/Debounce settings. Should usually not be changed.
      throttle = {
        refresh = 20, -- fetches new data when needed
        update = 10,  -- updates the window
        render = 10,  -- renders the window
        follow = 100, -- follows the current item
        preview = {
          ms = 100,
          debounce = true
        }, -- shows the preview for the current item
      },
      -- Key mappings can be set to the name of a builtin action,
      -- or you can define your own custom action.
      keys = {
        ['?'] = 'help',
        r = 'refresh',
        R = 'toggle_refresh',
        q = 'close',
        o = 'jump_close',
        ['<esc>'] = 'cancel',
        ['<cr>'] = 'jump',
        ['<2-leftmouse>'] = 'jump',
        ['<c-x>'] = 'jump_split',
        ['<c-v>'] = 'jump_vsplit',
        i = 'inspect',
        p = 'preview',
        P = 'toggle_preview',
        W = 'fold_open_recursive',
        w = 'fold_close_recursive',
        h = 'fold_toggle',
        l = 'jump',
      },

      icons = {
        indent        = {
          top         = '│ ',
          middle      = '├╴',
          last        = '└╴',
          -- last          = "-╴",
          -- last       = "╰╴", -- rounded
          fold_open   = ' ',
          fold_closed = ' ',
          ws          = '  ',
        },
        folder_closed = ' ',
        folder_open   = ' ',
        kinds         = {
          Array         = ' ',
          Boolean       = ' ',
          Class         = ' ',
          Constant      = '󰏿 ',
          Constructor   = ' ',
          Enum          = ' ',
          EnumMember    = ' ',
          Event         = ' ',
          Field         = ' ',
          File          = ' ',
          Function      = ' ',
          Interface     = '󰌗 ',
          Key           = ' ',
          Method        = ' ',
          Module        = '󰅩 ',
          Namespace     = '󰦮 ',
          Null          = ' ',
          Number        = '󰎠 ',
          Object        = ' ',
          Operator      = ' ',
          Package       = ' ',
          Property      = ' ',
          String        = ' ',
          Struct        = ' ',
          TypeParameter = '󰗴 ',
          Variable      = ' ',
        },
      },
    })
  end,
}
