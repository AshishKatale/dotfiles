return {
  'yetone/avante.nvim',
  lazy = true,
  cmd = { 'AvanteAsk', 'AvanteClear', 'AvanteEdit' },
  version = false, -- Never set this value to "*"! Never!
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'hrsh7th/nvim-cmp',              -- autocompletion for avante commands and mentions
    'nvim-tree/nvim-web-devicons',   -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua',        -- for providers='copilot'
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'Avante' },
      },
      ft = { 'Avante' },
    },
  },
  opts = {
    -- add any opts here
    -- for example
    provider = 'copilot',
    windows = {
      position = 'right',
      width = 40,         -- default % based on available width
      sidebar_header = {
        enabled = true,   -- true, false to enable/disable the header
        align = 'center', -- left, center, right for title
        rounded = false,
      },
      edit = {
        border = 'rounded',
        start_insert = true, -- Start insert mode when opening the edit window
      },
    }
  }
}
