local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	print("Unable to load: nvimtree")
  return
end

local keybind_list = {
	{ key = { "<CR>", 'l', "o", "<2-LeftMouse>" }, action = "edit" },
	{ key = "<C-e>",                               action = "edit_in_place" },
	{ key = { "o" },                               action = "edit_no_picker" },
	{ key = { "=" },                               action = "cd" },
	{ key = "<C-v>",                               action = "vsplit" },
	{ key = "<C-h>",                               action = "split" },
	{ key = "<C-t>",                               action = "tabnew" },
	{ key = "<",                                   action = "prev_sibling" },
	{ key = ">",                                   action = "next_sibling" },
	{ key = "P",                                   action = "parent_node" },
	{ key = "h",                                   action = "close_node" },
	{ key = "<Tab>",                               action = "preview" },
	{ key = "K",                                   action = "first_sibling" },
	{ key = "J",                                   action = "last_sibling" },
	{ key = "I",                                   action = "toggle_git_ignored" },
	{ key = "H",                                   action = "toggle_dotfiles" },
	{ key = "H",                                   action = "toggle_custom" },
	{ key = "<C-r>",                               action = "refresh" },
	{ key = "n",                                   action = "create" },
	{ key = "d",                                   action = "remove" },
	{ key = "D",                                   action = "trash" },
	{ key = "r",                                   action = "rename" },
	{ key = "R",                                   action = "full_rename" },
	{ key = "x",                                   action = "cut" },
	{ key = "c",                                   action = "copy" },
	{ key = "p",                                   action = "paste" },
	{ key = "y",                                   action = "copy_name" },
	{ key = "gy",                                  action = "copy_path" },
	{ key = "Y",                                   action = "copy_absolute_path" },
	{ key = "<C-n>",                               action = "prev_git_item" },
	{ key = "<F14>",                               action = "next_git_item" },
	{ key = "-",                                   action = "dir_up" },
	{ key = "O",                                   action = "system_open" },
	{ key = "q",                                   action = "close" },
	{ key = "g?",                                  action = "toggle_help" },
	{ key = "w",                                   action = "expand_all" },
	{ key = "W",                                   action = "collapse_all" },
	{ key = "S",                                   action = "search_node" },
	{ key = "<C-f>",                               action = "search_node" },
	{ key = "<C-k>",                               action = "toggle_file_info" },
	{ key = ".",                                   action = "run_file_command" },
	{ key = "f",                                   action = "live_filter" },
	{ key = "F",                                   action = "clear_live_filter" },
	{ key = "m",                                   action = "toggle_mark" },
}

nvim_tree.setup {
	auto_reload_on_write = true,
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
	renderer = {
		group_empty = false,
		highlight_opened_files = "none",
		root_folder_modifier = ":t",
		add_trailing = false,
		highlight_git = false,
		full_name = false,
		highlight_modified = "none",
		root_folder_label = ":~:s?$?/..?",
		indent_width = 2,
		icons = {
			webdev_colors = true,
			git_placement = "signcolumn",
			modified_placement = "signcolumn",
			padding = " ",
			symlink_arrow = " 󰁕 ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
				modified = true,
			},
      glyphs = {
        default = "",
        symlink = "",
				bookmark = "",
				modified = "󰷬",
        folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
          arrow_open = "",
          arrow_closed = "",
          symlink_open = "",
        },
				git = {
					unstaged = "󰐗",
					staged = "",
					unmerged = "",
					renamed = "",
					deleted = "",
					untracked = "",
					ignored = "",
				},
      },
    },
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
				bottom = "─",
        none = "  ",
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom = { "^\\.git$", "^node_modules$" },
		exclude = {},
  },
	modified = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = false,
	},
	diagnostics = {
    enable = true,
		show_on_dirs = true,
		show_on_open_dirs = false,
    icons = {
			info = "",
      hint = "󰌵",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = true,
		show_on_dirs = true,
		show_on_open_dirs = false,
		timeout = 500,
  },
	view ={
		centralize_selection = false,
		cursorline = true,
		debounce_delay = 15,
		width = 30,
		hide_root_folder = false,
		side = "right",
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		mappings = {
			custom_only = true,
			list = keybind_list
		},
		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
	},
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
	live_filter = {
		prefix = "  : ",
		always_show_folders = true,
	},
	ui = {
		confirm = {
			remove = true,
			trash = true,
		},
	},
}

