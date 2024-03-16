local plugins = {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lua/plenary.nvim",       lazy = true },
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("user.settings.theme")
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    cmd = { "NvimTreeToggle" },
    config = function()
      require("user.plugins.nvimtree")
    end,
  },
  {
    "mbbill/undotree",
    lazy = true,
    cmd = { "UndotreeToggle" },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 2
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "arkav/lualine-lsp-progress"
    },
    config = function()
      require("user.plugins.lualine")
    end,
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("user.plugins.whichkey")
    end,
  },
  {
    "tpope/vim-surround",
    lazy = true,
    event = { "BufEnter *.*" }
  },
  -- {
  --   'windwp/nvim-autopairs',
  --   event = "InsertEnter",
  --   opts = {
  --     disable_filetype = { "TelescopePrompt", "spectre_panel" },
  --   }
  -- },
  {
    "petertriho/nvim-scrollbar",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("user.plugins.utils.scrollbar")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("user.plugins.utils.colorizer")
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("user.plugins.utils.dressing")
    end
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    cmd = { "LazyGit", "Vifm", "ToggleTerm", "NpmStart", "NpmRunDev", "HttpServer" },
    keys = { "<C-\\>" },
    config = function()
      require("user.plugins.toggleterm")
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = "BufEnter *.*",
    config = function()
      require("user.plugins.utils.todo")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    main = "ibl",
    event = "BufEnter *.*",
    config = function()
      require("user.plugins.utils.blankline")
    end,
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = "Trouble",
    config = function()
      require("user.plugins.utils.trouble")
    end,
  },
  { "debugloop/telescope-undo.nvim", lazy = true },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    keys = { "<C-f>", "<C-p>" },
    cmd = { "Telescope" },
    config = function()
      require("user.plugins.telescope")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    event = "BufEnter *.*",
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    event = "BufEnter *.*",
    config = function()
      require("user.plugins.utils.comments")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "BufEnter *.*",
    config = function()
      require("user.plugins.utils.gitsigns")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "BufEnter *.*",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("user.settings.treesitter")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter *.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      require("user.plugins.lsp.nvimcmp")
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    event = { "VeryLazy" },
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("user.plugins.lsp")
    end
  },
}

return plugins
