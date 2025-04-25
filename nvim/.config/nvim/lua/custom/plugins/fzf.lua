return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = true,
  cmd = { 'FzfLua' },
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require('fzf-lua').register_ui_select(
      ---@diagnostic disable-next-line: unused-local
        function(opts, _items)
          -- remove ':' or '>' from end of the prompt string
          local title = vim.trim(opts.prompt or ''):gsub('[>: ]*$', '')
          local is_codeaction = opts.kind == 'codeaction'
          return vim.tbl_deep_extend('force', opts, {
            prompt = '   ',
            winopts = {
              title = #title > 0 and ' ' .. title .. ' ' or nil,
              width = is_codeaction and 0.85 or 0.5,
              height = is_codeaction and 0.85 or 0.4,
            }
          })
        end
      )
      return vim.ui.select(...)
    end
  end,
  opts = function()
    local actions = require('fzf-lua').actions

    local function dropdown_with_title(title)
      return {
        title = ' ' .. title .. ' ',
        height = 0.4,
        width = 0.5,
        row = 0.5,
        col = 0.5,
        preview = {
          hidden = 'hidden',
        },
      }
    end

    local function window_with_preview(title, border)
      return {
        title = ' ' .. title .. ' ',
        preview = {
          border = border or 'rounded',
          layout = 'horizontal',
        },
      }
    end

    return {

      fzf_opts = {
        ['--cycle'] = true,
        ['--preview-window'] = 'right:60%:border-left',
        ['--scrollbar'] = '┃',
        ['--pointer'] = '󰜴',
        ['--marker'] = '',
        ['--prompt'] = '   ',
      },

      fzf_colors = {
        ['gutter'] = '-1',
        ['header'] = { 'fg', { 'Pmenu' }, 'bold' },
        ['marker'] = { 'fg', { 'Pmenu' } },
        ['border'] = { 'fg', { 'VertSplit' } },
        ['pointer'] = { 'fg', { 'PmenuSel' } },
        ['separator'] = { 'fg', { 'VertSplit' } },
        ['prompt'] = { 'fg', { 'DiagnosticInfo' }, 'bold' },
        ['fg+'] = { 'fg', { 'PmenuSel' } },
        ['bg+'] = { 'bg', { 'PmenuSel' } },
        ['hl'] = { 'fg', { 'DiagnosticInfo' }, 'bold' },
        ['hl+'] = { 'fg', { 'DiagnosticInfo' }, 'bold' },
      },

      hls = {
        border         = 'VertSplit',
        help_border    = 'VertSplit',
        preview_border = 'VertSplit',
        title          = '@markup.heading',
        scrollborder_f = 'PmenuThumb',
      },

      winopts = {
        title_pos = 'center',
        title_flags = true,
        row = 0.5,
        col = 0.5,
        width = 0.85,
        height = 0.85,
        border = 'rounded',
        preview = {
          hidden     = 'nohidden',
          vertical   = 'down:50%',
          horizontal = 'right:60%',
          border     = 'rounded',
          wrap       = true,
        },
        treesitter = { enabled = true },
      },

      help_open_win = function(buf, enter, opts)
        opts.border = 'rounded'
        return vim.api.nvim_open_win(buf, enter, opts)
      end,

      previewers = {
        builtin = {
          -- do not add syntax highlights to large files
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },

      keymap = {
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          false,                 -- inherit defaults in your custom config
          ['<M-Esc>']  = 'hide', -- hide fzf-lua, `:FzfLua resume` to continue
          ['<M-e>']    = 'preview-down',
          ['<M-y>']    = 'preview-up',
          ['<C-_>']    = 'toggle-help',
          ['<C-d>']    = 'preview-half-page-down',
          ['<C-u>']    = 'preview-half-page-up',
          ['<C-q>']    = 'file-selection-to-qf',
          ['<M-p>']    = 'toggle-preview',
          ['<M-w>']    = 'toggle-preview-wrap',
          ['<M-S-f>']  = 'toggle-fullscreen',
          -- Rotate preview clockwise/counter-clockwise
          ['<F5>']     = 'toggle-preview-ccw',
          ['<F6>']     = 'toggle-preview-cw',
          -- -- `ts-ctx` binds require `nvim-treesitter-context`
          ['<F7>']     = 'toggle-preview-ts-ctx',
          ['<F8>']     = 'preview-ts-ctx-dec',
          ['<F9>']     = 'preview-ts-ctx-inc',
          ['<S-Left>'] = 'preview-reset',
        },
        fzf = {
          -- fzf '--bind=' options
          false, -- inherit defaults in your custom config
          ['ctrl-d'] = 'preview-half-page-down',
          ['ctrl-u'] = 'preview-half-page-up',
          ['ctrl-f'] = 'half-page-down',
          ['ctrl-b'] = 'half-page-up',
          ['ctrl-a'] = 'toggle-all',
          ['ctrl-o'] = 'toggle',
          ['ctrl-z'] = 'abort',
          ['alt-e']  = 'preview-down',
          ['alt-y']  = 'preview-up',
          ['alt-g']  = 'first',
          ['alt-G']  = 'last',
          -- only valid with fzf previewers (bat/cat/git/etc)
          ['alt-w']  = 'toggle-preview-wrap',
          ['alt-p']  = 'toggle-preview',
        },
      },

      actions = {
        files = {
          false,
          ['ctrl-q'] = actions.file_sel_to_qf,
          ['ctrl-v'] = actions.file_vsplit,
          ['ctrl-x'] = actions.file_split,
          ['alt-f']  = actions.toggle_follow,
          ['alt-i']  = actions.toggle_ignore,
          ['alt-h']  = actions.toggle_hidden,
          ['enter']  = actions.file_edit,
        }
      }, -- Fzf "accept" binds

      files = {
        git_icons  = false,
        no_header  = true,
        cwd_header = true,
        cwd_prompt = false,
        winopts    = dropdown_with_title('Find Files'),
        fzf_opts   = { ['--tiebreak'] = 'end' },
      },
      grep = {
        multiprocess = true, -- run command in a separate process
        grep_opts    = '--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e',
        rg_opts      = '--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
        winopts      = window_with_preview('Grep')
      },
      buffers = {
        no_header = true,
        fzf_opts  = { ['--tiebreak'] = 'begin' },
        formatter = 'path.filename_first',
        winopts   = dropdown_with_title('Buffers')
      },
      oldfiles = {
        include_current_session = true,
      },
      filetypes = {
        winopts = dropdown_with_title('Filetypes')
      },
      helptags = {
        winopts = window_with_preview('Help')
      },
      keymaps = {
        winopts = window_with_preview('Keymaps')
      },
      git = {
        branches = {
          no_header = true,
          winopts = window_with_preview('Branches', 'border-left'),
        },
        status = {
          fzf_opts  = { ['--tiebreak'] = 'begin' },
          formatter = 'path.filename_first',
          winopts   = window_with_preview('Git Status', 'border-left'),
        },
        icons = {
          ['M'] = { icon = '󰐙', color = 'blue' },
          ['D'] = { icon = '󰮈', color = 'red' },
          ['A'] = { icon = '󰐙', color = 'green' },
          ['R'] = { icon = '󰳠', color = 'green' },
          ['?'] = { icon = '󰘥', color = 'green' },
          -- ['C'] = { icon = '󰐙', color = 'yellow' },
          -- ['T'] = { icon = '󰐙', color = 'magenta' },
        },
      },
      lsp = {
        code_actions = {
          prompt           = '   ',
          async_or_timeout = 10000,
          winopts          = window_with_preview('Code Actions'),
        },
      },
    }
  end
}
