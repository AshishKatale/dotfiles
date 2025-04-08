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
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua',      -- for providers='copilot'
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = function()
        vim.cmd('hi  RenderMarkdownCode guibg=NONE')
        return {
          file_types = { 'Avante', 'markdown' },
        }
      end,
      cmd = 'RenderMarkdown',
      ft = { 'Avante' },
    },
    {
      'hrsh7th/nvim-cmp',
      lazy = true,
      ft = { 'AvanteInput' },
      opts = function()
        local cmp = require('cmp')
        return {
          enabled = function()
            return vim.tbl_contains({ 'AvanteInput' }, vim.bo.filetype)
          end,
          completion = {
            autocomplete = { cmp.TriggerEvent.TextChanged, }
          },
          formatting = {
            fields = { 'kind', 'abbr' },
            format = function(_, item)
              item.kind = ''
              return item
            end,
          },
          window = {
            completion = {
              border = 'rounded', winhighlight = 'CursorLine:PmenuSel',
            },
            documentation = {
              border = 'rounded', winhighlight = 'CursorLine:PmenuSel',
            }
          },
          mapping = {
            ['<C-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-c>'] = cmp.mapping {
              i = cmp.mapping.abort(),
              c = cmp.mapping.close(),
            },
            ['<CR>'] = cmp.mapping.confirm({
              select = true,
              behavior = cmp.ConfirmBehavior.Insert
            }),
            ['<C-p>'] = cmp.mapping(
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                else
                  fallback()
                end
              end,
              { 'i', 's' }
            ),
            ['<C-n>'] = cmp.mapping(
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  fallback()
                end
              end,
              { 'i', 's' }
            ),
          },
        }
      end,
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
  },
  config = function(_, opts)
    require('avante').setup(opts);
    vim.cmd([[
      hi  RenderMarkdownCode guibg=NONE
      hi! link AvantePromptInputBorder FloatBorder
      hi! link AvanteSidebarWinSeparator FloatBorder
    ]])
  end
}
