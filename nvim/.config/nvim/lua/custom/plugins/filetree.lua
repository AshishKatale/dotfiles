local M = {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = true,
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeClose' },
}

M.opts = function()
  return {
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      local utils = require('custom.plugins.utils.fn')
      local map = vim.keymap.set

      local function o(desc)
        return {
          desc = 'nvim-tree: ' .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true
        }
      end

      local function find()
        local node = api.tree.get_node_under_cursor()
        if node.type == 'directory' then
          utils.find_in_dir(node.absolute_path, node.name)
        else
          utils.find_in_dir(node.parent.absolute_path, node.parent.name)
          vim.api.nvim_echo({ {
              node.name ..
              ' is not a directory, searching in ' ..
              node.parent.name
            } },
            false, -- don't add to message history
            { err = false }
          )
        end
      end

      map('n', 'F', find, o('Find in directory'))
      map('n', 'l', api.node.open.edit, o('Open'))
      map('n', '<CR>', api.node.open.edit, o('Open'))
      map('n', '<2-LeftMouse>', api.node.open.edit, o('Open'))
      map('n', 'o', api.node.open.no_window_picker, o('Open: No Window Picker'))
      map('n', 'O', api.node.run.system, o('Run System'))
      map('n', '.', api.node.run.cmd, o('Run Command'))
      map('n', '<C-e>', api.node.open.replace_tree_buffer, o('Open: In Place'))
      map('n', '<C-v>', api.node.open.vertical, o('Open: Vertical Split'))
      map('n', '<C-x>', api.node.open.horizontal, o('Open: Horizontal Split'))
      map('n', '<C-t>', api.node.open.tab, o('Open: New Tab'))
      map('n', '<Tab>', api.node.open.preview, o('Open Preview'))
      map('n', '<', api.node.navigate.sibling.prev, o('Previous Sibling'))
      map('n', '>', api.node.navigate.sibling.next, o('Next Sibling'))
      map('n', 'P', api.node.navigate.parent, o('Parent Directory'))
      map('n', 'h', api.node.navigate.parent_close, o('Close Directory'))
      map('n', 'K', api.node.navigate.sibling.first, o('First Sibling'))
      map('n', 'J', api.node.navigate.sibling.last, o('Last Sibling'))
      map('n', '<C-p>', api.node.navigate.git.prev, o('Prev Git'))
      map('n', '<C-n>', api.node.navigate.git.next, o('Next Git'))
      map('n', '<C-k>', api.node.show_info_popup, o('Info'))
      map('n', 'I', api.tree.toggle_gitignore_filter, o('Toggle Git Ignore'))
      map('n', 'H', api.tree.toggle_hidden_filter, o('Toggle Dotfiles'))
      map('n', 'H', api.tree.toggle_custom_filter, o('Toggle Hidden'))
      map('n', 'q', api.tree.close, o('Close'))
      map('n', '?', api.tree.toggle_help, o('Help'))
      map('n', 'W', api.tree.expand_all, o('Expand All'))
      map('n', 'w', api.tree.collapse_all, o('Collapse'))
      map('n', 'S', api.tree.search_node, o('Search'))
      map('n', '=', api.tree.change_root_to_node, o('CD'))
      map('n', '-', api.tree.change_root_to_parent, o('Up'))
      map('n', '<C-r>', api.tree.reload, o('Refresh'))
      map('n', '<C-f>', api.tree.search_node, o('Search'))
      map('n', 'n', api.fs.create, o('Create'))
      map('n', 'd', api.fs.remove, o('Delete'))
      map('n', 'D', api.fs.trash, o('Trash'))
      map('n', 'r', api.fs.rename, o('Rename'))
      map('n', 'R', api.fs.rename_sub, o('Rename: Omit Filename'))
      map('n', 'x', api.fs.cut, o('Cut'))
      map('n', 'c', api.fs.copy.node, o('Copy'))
      map('n', 'p', api.fs.paste, o('Paste'))
      map('n', 'gy', api.fs.copy.filename, o('Copy Name'))
      map('n', 'y', api.fs.copy.absolute_path, o('Copy Absolute Path'))
      map('n', 'Y', api.fs.copy.relative_path, o('Copy Relative Path'))
      map('n', 'm', api.marks.toggle, o('Toggle Bookmark'))
      map('n', 'bd', api.marks.bulk.delete, o('Delete Bookmarked'))
      map('n', 'bt', api.marks.bulk.trash, o('Trash Bookmarked'))
      map('n', 'bm', api.marks.bulk.move, o('Move Bookmarked'))
    end
  }
end


M.config = function(_, opts)
  require('nvim-tree').setup {
    on_attach = opts.on_attach,
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    renderer = {
      group_empty = false,
      highlight_opened_files = 'none',
      root_folder_modifier = ':t',
      add_trailing = false,
      highlight_git = false,
      full_name = false,
      highlight_modified = 'none',
      root_folder_label = ':~:s?$?/..?',
      indent_width = 2,
      icons = {
        webdev_colors = true,
        git_placement = 'signcolumn',
        modified_placement = 'signcolumn',
        padding = ' ',
        symlink_arrow = ' 󰁕 ',
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
        },
        glyphs = {
          default = '',
          symlink = '',
          bookmark = '',
          modified = '󰷬',
          folder = {
            default = '',
            open = '',
            empty = '',
            empty_open = '',
            symlink = '',
            arrow_open = '',
            arrow_closed = '',
            symlink_open = '',
          },
          git = {
            unstaged = '󰐙',
            staged = '󰗡',
            unmerged = '',
            renamed = '󰳠',
            deleted = '󰮈',
            untracked = '󰘥',
            ignored = '󰍷',
          },
        },
      },
      indent_markers = {
        enable = true,
        icons = {
          corner = '└ ',
          edge = '│ ',
          item = '├ ',
          bottom = '─',
          none = '  ',
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
      ignore_list = {},
    },
    system_open = {
      cmd = nil,
      args = {},
    },
    filters = {
      dotfiles = false,
      custom = { '^\\.git$', '^node_modules$' },
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
        info = '',
        hint = '󰘥',
        warning = '',
        error = '󰅚',
      },
    },
    git = {
      enable = true,
      ignore = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
      timeout = 500,
    },
    view = {
      centralize_selection = false,
      cursorline = true,
      debounce_delay = 15,
      width = 30,
      side = 'right',
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = 'yes',
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = 'editor',
          border = 'rounded',
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    trash = {
      cmd = 'trash',
      require_confirm = true,
    },
    live_filter = {
      prefix = '  : ',
      always_show_folders = true,
    },
    ui = {
      confirm = {
        remove = true,
        trash = true,
      },
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
        exclude = {},
      },
      file_popup = {
        open_win_config = {
          col = 1,
          row = 1,
          relative = 'cursor',
          border = 'rounded',
          style = 'minimal',
        },
      },
      open_file = {
        quit_on_open = true,
        eject = true,
        resize_window = true,
      },
      remove_file = {
        close_window = false,
      },
    },
  }
end

return M
