local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
  },
  lazy = true,
  keys = { "<C-f>", "<C-p>" },
  cmd = { "Telescope" },
}

M.opts = function()
  local trouble = require("trouble.providers.telescope")
  local actions = require("telescope.actions")

  local mappings = {
    i = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      ["<Tab>"] = actions.move_selection_next,
      ["<S-Tab>"] = actions.move_selection_previous,
      ["<leader><leader>"] = actions.toggle_selection,

      ["<C-c>"] = actions.close,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,

      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      -- ["<C-t>"] = actions.select_tab,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,

      ["<C-j>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<C-k>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-w>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<C-q>"] = trouble.open_with_trouble,
      ["<M-q>"] = trouble.open_selected_with_trouble,
      ["<C-l>"] = actions.complete_tag,
      ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    },

    n = {
      ["<C-c>"] = actions.close,
      ["<CR>"] = actions.select_default,
      ["l"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      -- ["<C-t>"] = actions.select_tab,

      ["<C-j>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<C-k>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-w>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<C-q>"] = trouble.open_with_trouble,
      ["<M-q>"] = trouble.open_selected_with_trouble,

      ["<leader><leader>"] = actions.toggle_selection,
      ["Tab"] = actions.move_selection_next,
      ["S-Tab"] = actions.move_selection_previous,
      ["j"] = actions.move_selection_next,
      ["k"] = actions.move_selection_previous,
      ["H"] = actions.move_to_top,
      ["M"] = actions.move_to_middle,
      ["L"] = actions.move_to_bottom,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,

      ["?"] = actions.which_key,
    },
  }

  local git_commit = {
    mappings = {
      n = {
        ["<cr>"] = actions.select_default,
        ["<A-cr>"] = actions.git_checkout,
      },
      i = {
        ["<cr>"] = actions.move_selection_next,
        ["<A-cr>"] = actions.git_checkout,
      },
    },
  }
  return {
    defaults = {
      layout_config = {
        prompt_position = "top", -- other layout configuration here
        horizontal = {
          preview_width = 80,
          height = 0.9,
          preview_cutoff = 120,
          width = 0.8
        },
      },
      sorting_strategy = "ascending",
      prompt_prefix = "   ",
      initial_mode = "insert",
      selection_caret = "󰜴 ",
      multi_icon = "",
      path_display = { "smart" },
      file_ignore_patterns = {
        "^.git/", ".cache", "%.o", "%.a",
        "%.out", "%.class", "%.pdf",
        "%.mkv", "%.mp4", "%.zip",
        "node_modules/",
      },
      mappings = mappings,
    },
    pickers = {
      buffers = {
        initial_mode = "normal",
      },
      live_grep = {
        additional_args = function() return { "--hidden" } end
      },
      git_status = {
        initial_mode = "normal",
      },
      git_branches = {
        initial_mode = "normal",
      },
      git_commits = git_commit,
      git_bcommits = git_commit
    },
  }
end

M.config = function(_, opts)
  local telescope = require("telescope")
  local telescope_builtin = require("telescope.builtin")
  telescope.setup(opts)
  vim.keymap.set(
    { "n", "i" }, "<C-f>",
    telescope_builtin.current_buffer_fuzzy_find,
    { silent = true }
  )
  vim.keymap.set(
    { "n", "i" }, "<C-p>",
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
