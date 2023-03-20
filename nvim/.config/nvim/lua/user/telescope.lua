local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print("Unable to load: cmp")
  return
end

telescope.load_extension('fzf');
telescope.load_extension('undo');
-- telescope.load_extension('media_files')

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
		layout_config = {
      vertical = { width = 0.5 },
			prompt_position = "top",     -- other layout configuration here
    },
		sorting_strategy="ascending",
    prompt_prefix = "   ",
		initial_mode = "insert",
    selection_caret = " ",
    path_display = { "smart" },
		file_ignore_patterns = {
			".git/", ".cache", "%.o", "%.a",
			"%.out", "%.class","%.pdf",
			"%.mkv", "%.mp4", "%.zip",
			"node_modules/",
		},
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<C-j>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<C-k>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-j>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<C-k>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

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
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
		buffers = {
			initial_mode = "normal",
		},
    find_files = {
      theme = "dropdown",
			previewer = false,
    },
		live_grep = {
			additional_args = function () return {"--hidden"} end
		}
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
		fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
		-- media_files = {
		-- 	filetypes whitelist defaults to {"png", "jpg", "mp4", "webm", "pdf"}
		-- 	filetypes = {"png", "webp", "jpg", "jpeg"},
		-- 	find_cmd = "rg" -- find command (defaults to `fd`)
		-- }
		undo = {
      use_delta = true,
      use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
      side_by_side = false,
      diff_context_lines = vim.o.scrolloff,
      entry_format = "state #$ID, $STAT, $TIME",
      mappings = {
        i = {
          ["<cr>"] = require("telescope-undo.actions").yank_additions,
          ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
          ["<C-cr>"] = require("telescope-undo.actions").restore,
        },
      },
    },
  },
}

-- Telescope keybinds
local telescope_builtin = require("telescope.builtin")
vim.keymap.set({ "n", "i" }, "<C-f>", telescope_builtin.current_buffer_fuzzy_find, { silent = true })
vim.keymap.set({ "n", "i" }, "<F15>", telescope_builtin.live_grep, { silent = true })     --  bind Shift+F3(f15) => <C-S-f> with autokey
vim.keymap.set({ "n", "i" }, "<C-p>", function () telescope_builtin.find_files({ hidden = true }) end, { silent = true })
