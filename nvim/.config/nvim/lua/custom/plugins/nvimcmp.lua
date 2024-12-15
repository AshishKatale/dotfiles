local M = {
  'hrsh7th/nvim-cmp',
  lazy = true,
  event = 'VeryLazy',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
}

M.opts = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  -- friendly-snippets - enable standardized comments snippets
  luasnip.filetype_extend('typescript', { 'tsdoc' })
  luasnip.filetype_extend('javascript', { 'jsdoc' })
  luasnip.filetype_extend('lua', { 'luadoc' })
  luasnip.filetype_extend('python', { 'pydoc' })
  luasnip.filetype_extend('rust', { 'rustdoc' })
  luasnip.filetype_extend('cs', { 'csharpdoc' })
  luasnip.filetype_extend('java', { 'javadoc' })
  luasnip.filetype_extend('c', { 'cdoc' })
  luasnip.filetype_extend('cpp', { 'cppdoc' })
  luasnip.filetype_extend('php', { 'phpdoc' })
  luasnip.filetype_extend('kotlin', { 'kdoc' })
  luasnip.filetype_extend('ruby', { 'rdoc' })
  luasnip.filetype_extend('sh', { 'shelldoc' })

  local kind_icons = {
    Text = '󰉨',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '󰌗',
    Module = '󰅩',
    Property = '',
    Unit = '',
    Value = '󰎠',
    Enum = '',
    Keyword = '',
    Snippet = '󰃐',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '[π]',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '󰗴',
  }

  return {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping(
        function(fallback)
          if luasnip.choice_active() then
            luasnip.change_choice(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end
      ),
      ['<C-n>'] = cmp.mapping(
        function(fallback)
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end
      ),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
      ['<C-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-c>'] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Insert
      }),
      ['<C-y>'] = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Insert
      }),
      ['<Tab>'] = cmp.mapping(
        function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end,
        { 'i', 's' }
      ),
      ['<S-Tab>'] = cmp.mapping(
        function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
        { 'i', 's' }
      ),
      ['<C-x>'] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.visible_docs() then
          cmp.close_docs()
        elseif cmp.visible() and not cmp.visible_docs() then
          cmp.open_docs()
        else
          fallback()
        end
      end)
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = '[LSP]',
          nvim_lua = '[LUA]',
          luasnip = '[SNIP]',
          buffer = '[BUF]',
          path = '[PATH]',
          nvim_lsp_signature_help = '[SIG]',
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = {
      { name = 'nvim_lsp_signature_help' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    },
    preselect = cmp.PreselectMode.Item,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    view = {
      entries = 'custom'
    },
    experimental = {
      ghost_text = false
    },
  }
end

M.config = function(_, opts)
  require('luasnip/loaders/from_vscode').lazy_load()
  require('cmp').setup(opts)
end

return M
