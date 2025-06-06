return {
  'folke/todo-comments.nvim',
  lazy = true,
  event = 'BufEnter',
  cmd = { 'TodoQuickfix', 'TodoTrouble', 'TodoFzfLua' },
  config = function()
    require('todo-comments').setup({
      signs = false,     -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = '', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          -- a set of other keywords that all map to  FIX:
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'FAIL', 'FAILED' },
          signs = false, -- configure signs for some keywords individually
        },
        WARN = { icon = '', color = 'warn', alt = { 'WARNING', 'XXX' } },
        NOTE = { icon = '󱇗', color = 'info', alt = { 'INFO', 'NOTICE' } },
        HACK = { icon = '󱠇', color = 'hack' },
        TODO = {
          icon = '',
          color = 'todo',
          alt = { 'REMIND', 'REMINDER', 'REMEMBER' }
        },
        PERF = {
          icon = '󱅳',
          color = 'perf',
          alt = { 'PERF', 'PERFORMANCE', 'OPTM', 'OPTIMIZE' }
        },
        TEST = {
          icon = '󱣬',
          color = 'test',
          alt = { 'TESTING', 'PASS', 'PASSED' }
        },
      },
      gui_style = {
        fg = 'NONE',         -- The gui style to use for the fg highlight group.
        bg = 'BOLD',         -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true,
      -- custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- before: highlights before the keyword (typically comment characters)
      -- keyword: highlights of the keyword
      -- after: highlights after the keyword (todo text)
      highlight = {
        multiline = true,            -- enable multine todo comments
        multiline_pattern = '^.',    -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,      -- extra lines that will be re-evaluated when changing a line
        before = '',                 -- "fg" or "bg" or empty
        keyword = 'wide',            -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty.
        after = 'fg',                -- "fg" or "bg" or empty
        pattern = [[\s(KEYWORDS):]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true,        -- uses treesitter to match keywords in comments only
        max_line_len = 400,          -- ignore lines longer than this
        exclude = {},                -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { 'DiagnosticError' },
        warn = { 'DiagnosticWarn' },
        info = { 'DiagnosticInfo' },
        hack = { 'DiagnosticWarn' },
        todo = { '#CCCC00' },
        test = { '#FF55FF' },
        perf = { '#7C3AED' },
        default = { '#7C3AED' },
      },
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        -- INFO regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\s\b(KEYWORDS):]], -- ripgrep regex
      },
    })
  end,
}
