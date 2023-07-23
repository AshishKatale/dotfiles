local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	print("Unable to load: nvimtree")
  return
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  vim.keymap.set('n', 'o', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', '=', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-h>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'H', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  vim.keymap.set('n', '<C-r>', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'n', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'gy', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'Y', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '<C-b>', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', '<C-n>', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'O', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'w', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', '<C-f>', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
  vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
  vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
end

nvim_tree.setup {
	on_attach = on_attach,
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

