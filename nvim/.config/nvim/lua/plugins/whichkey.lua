local M = {
  "folke/which-key.nvim",
  lazy = true,
  event = "VeryLazy",
}

M.opts = function()
  return {
    plugins = {
      marks = true,       -- shows a list of your marks on ' and `
      registers = true,   -- shows your registers on " or <C-r>
      spelling = {
        enabled = true,   -- press z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- presets add help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = true,
        nav = false,
        z = true,
        g = true,
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys.
      -- It doesn't effect WK in any other way.
      -- For example:
      ["<space>"] = "󱁐",
      ["<cr>"] = "󱞦",
      ["<tab>"] = "󰞔",
      ["<esc>"] = "󱊷",
    },
    icons = {
      breadcrumb = "󰁕", -- symbol used in the command line area that shows your active key combo
      separator = "󰜴", -- symbol used between a key and it's label
      group = "󰄠 ", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded",       -- none, single, double, shadow
      position = "bottom",      -- bottom, top
      margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
      padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 5, max = 25 },
      width = { min = 20, max = 30 },
      spacing = 2,
      align = "left",
    },
    ignore_missing = true,
    hidden = {
      "<silent>", "<cmd>", "<Cmd>",
      "<CR>", "call", "lua", "^:", "^ "
    },
    show_help = true,
    triggers = "auto",
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "i", "i" },
    },
    triggers_nowait = {
      -- marks
      "`",
      "'",
      "g`",
      "g'",
    }
  }
end

M.config = function(_, setup)
  local which_key = require("which-key")
  local utils = require("plugins.utils.fn")
  local mappings = {
    ["<leader>"] = { "<cmd>tabnew term://$SHELL<CR>", "Terminal" },
    b = { "<cmd>Telescope buffers<CR>", "Buffers" },
    e = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },
    E = { "<cmd>Vifm<CR>", "Vifm" },
    h = { "<C-w>h", "Left split" },
    l = { "<C-w>l", "Right split" },
    j = { "<C-w>j", "Lower split" },
    k = { "<C-w>k", "Upper split" },
    u = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
    q = {
      name = "QuickFix List",
      q = { "<cmd>copen<cr>", "Workspace Diagnostics" },
      d = { "<cmd>Trouble document_diagnostics<cr>", "File Diagnostics" },
      D = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
      g = { "<cmd>Gitsigns setqflist<cr>", "Git Hunks" },
      i = { "<cmd>Trouble lsp_implementations<cr>", "Implementations" },
      t = { "<cmd>Trouble lsp_type_definitions<cr>", "Type Definitions" },
      T = { "<cmd>TodoTrouble<cr>", "Todos" },
    },
    g = {
      name = "Git Stuff",
      C = { "<cmd>Telescope git_commits prompt_title=Git\\ History<cr>",
        "Commits" },
      c = { "<cmd>Telescope git_bcommits prompt_title=File\\ History<cr>",
        "File Commits" },
      s = { "<cmd>Telescope git_status<cr>", "Git status" },
      b = { "<cmd>Telescope git_branches<cr>", "Branches" },
      B = { "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame line" },
      p = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview hunk" },
      P = { "<cmd>lua require('gitsigns').preview_hunk_inline()<cr>",
        "Preview hunk inline" },
      f = { "<cmd>Telescope git_files<CR>", "Git Files" },
      d = { "<cmd>lua require('gitsigns').diffthis()<cr>", "File diff" },
      r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset hunk" },
      R = { "<cmd>lua require('gitsigns').reset_buffer()<cr>", "Reset buffer" },
      S = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage hunk" },
      U = { "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>",
        "Undo stage hunk" },
      g = { "<cmd>LazyGit<cr>", "LazyGit" },
      G = { "<cmd>Gitsigns<cr>", "GitSigns menu" }
    },
    s = {
      name = "Search",
      C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      c = { "<cmd>Telescope commands<cr>", "Commands" },
      s = { "<cmd>Telescope live_grep<CR>", "Search in Workspace" },
      f = {
        "<cmd>Telescope find_files hidden=true" ..
        "layout_config={previewer=true}<CR>",
        "Find files"
      },
      w = {
        function() utils.search_string(vim.fn.expand("<cword>")) end,
        "Find word Under Cursor"
      },
      W = {
        function() utils.search_string(vim.fn.expand("<cWORD>")) end,
        "Find WORD Under Cursor"
      },
    },
    o = {
      name = "Open",
      L = { "<cmd>Lazy<cr>", "Lazy" },
      l = { "<cmd>LspInfo<cr>", "LspInfo" },
      m = { "<cmd>Mason<cr>", "Mason" },
    },
    t = {
      name = "Toggle",
      o = { "<cmd>OpacityToggle<cr>", "Background Opacity" },
      q = { "<cmd>TroubleToggle<cr>", "QuickFix/Trouble" },
      c = { "<cmd>ColorizerToggle<cr>", "Colorizer" },
      C = { "<cmd>ColorColumnToggle<cr>", "Color Column" },
      d = { "<cmd>DiagnosticsToggle<cr>", "Diagnostics" },
      h = { "<cmd>InlayhintsToggle<cr>", "Inlay hints" },
      f = { "<cmd>FormatOnSaveToggle<cr>", "Format on Save" },
      s = { "<cmd>ScrollbarToggle<cr>", "Scrollbar" },
      t = { "<cmd>TSContextToggle<cr>", "Treesitter context" },
      T = { "<cmd>TSToggle highlight<cr>", "Treesitter highlight" },
      b = { "<cmd>BlanklineToggle<cr>", "Blankline" },
      g = { "<cmd>Gitsigns toggle_signs<cr>", "Gitsigns" },
      B = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Git Blame" },
    },
  }

  local opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  which_key.register(mappings, opts)

  -- visual mode keybinds
  opts = vim.tbl_extend("force", opts, {
    mode = "v"
  })
  mappings = {
    s = { utils.search_selection, "Search visual selection" },
  }
  which_key.register(mappings, opts)

  -- C-k mappings
  opts = vim.tbl_extend("force", opts, {
    mode = { "i", "n" },
    prefix = "<C-k>",
  })
  mappings = {
    x = { "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>", "Delete Buffer" },
    ["<C-x>"] = { "<cmd>1,$bd!<CR>", "Delete All Buffers" },
    l = { utils.set_filetype, "Set Filetype" },
  }
  which_key.register(mappings, opts)

  which_key.setup(setup)
end

return M
