local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
  },
  lazy = true,
  keys = { '<C-b>' },
  cmd = { 'Telescope' },
}

M.opts = function()
  local trouble = require('trouble.sources.telescope')
  local actions = require('telescope.actions')

  local mappings = {
    i = {
      ['<A-p>'] = actions.cycle_history_prev,
      ['<A-n>'] = actions.cycle_history_next,
      ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
      ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
      ['<C-w>'] = trouble.open,
      ['<C-c>'] = actions.close,
      ['<C-l>'] = actions.drop_all,
    },

    n = {
      ['<A-p>'] = actions.cycle_history_prev,
      ['<A-n>'] = actions.cycle_history_next,
      ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
      ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
      ['<C-w>'] = trouble.open,
      ['<C-c>'] = actions.close,
      ['<C-l>'] = actions.drop_all,
      ['<leader><leader>'] = actions.toggle_selection,
    },
  }

  local git_commit = {
    mappings = {
      n = {
        ['<CR>'] = actions.select_default,
        ['<A-CR>'] = actions.git_checkout,
      },
      i = {
        ['<CR>'] = actions.move_selection_next,
        ['<A-CR>'] = actions.git_checkout,
      },
    },
  }
  return {
    defaults = {
      layout_config = {
        prompt_position = 'top', -- other layout configuration here
        horizontal = {
          preview_width = 80,
          height = 0.9,
          preview_cutoff = 120,
          width = 0.8
        },
      },
      sorting_strategy = 'ascending',
      prompt_prefix = '   ',
      initial_mode = 'insert',
      selection_caret = '󰜴 ',
      multi_icon = '',
      path_display = { 'smart' },
      file_ignore_patterns = {
        '^.git/', '.cache', '%.o', '%.a',
        '%.out', '%.class', '%.pdf',
        '%.mkv', '%.mp4', '%.zip',
        'node_modules/',
      },
      mappings = mappings,
    },
    pickers = {
      buffers = {
        initial_mode = 'normal',
      },
      git_status = {
        initial_mode = 'normal',
      },
      git_branches = {
        initial_mode = 'normal',
      },
      live_grep = {
        additional_args = function() return { '--hidden' } end
      },
      git_commits = git_commit,
      git_bcommits = git_commit
    },
  }
end

M.config = function(_, opts)
  local telescope = require('telescope')
  local telescope_builtin = require('telescope.builtin')
  telescope.setup(opts)
  vim.keymap.set(
    { 'n', 'i' }, '<C-b>',
    function()
      telescope_builtin.find_files(
        require('telescope.themes').get_dropdown {
          previewer = false,
          hidden = true
        }
      )
    end,
    { silent = true }
  )
end

return M
