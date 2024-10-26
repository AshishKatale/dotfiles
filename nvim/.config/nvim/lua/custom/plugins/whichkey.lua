local M = {
  'folke/which-key.nvim',
  lazy = true,
  event = 'VeryLazy',
}

M.opts = function()
  return {
    preset = 'classic',
    -- delay before showing the popup. can be a number or a function
    delay = 500,
    --- you can add any mappings here, or use `require('which-key').add()` later
    spec = {},
    -- show a warning when issues were detected with your mappings
    notify = true,
    -- enable/disable whichkey for certain mapping modes
    plugins = {
      marks = true,     -- shows a list of your marks on ' and `
      registers = true, -- show registers on " in normal or <c-r> in insert mode
      -- the presets plugin, adds help default keybindings in neovim
      -- no actual key bindings are created
      spelling = {
        enabled = true,   -- enable z= to select spelling suggestions
        suggestions = 25, -- how many suggestions should be shown in the list?
      },
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
    win = {
      height = { min = 3 },
      row = -2,
      border = 'rounded',
      padding = { 0, 1 }, -- extra window padding [top/bottom, right/left]
      title = true,
      title_pos = 'left',
      zindex = 1000,
    },
    layout = {
      width = { min = 20 }, -- min and max width of the columns
      spacing = 2,          -- spacing between columns
      align = 'left',       -- align columns left, center or right
    },
    keys = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>',   -- binding to scroll up inside the popup
    },
    sort = { 'local', 'order', 'group', 'alphanum', 'mod', 'lower', 'icase' },
    expand = 1, -- expand groups when <= n mappings
    icons = {
      mappings = false, -- disable icons
      breadcrumb = '󰁕', -- symbol used in the command line area
      separator = '󰜴', -- symbol used between a key and it's label
      group = '󰄠 ', -- symbol prepended to a group
      ellipsis = '',
      --- see `lua/which-key/icons.lua` for more details
      rules = {},
      -- use the highlights from mini.icons
      -- when `false`, it will use `whichkeyicon` instead
      colors = true,
      -- used by key format
      keys = {
        cr = '󱞦 ',
        NL = '󱞦 ',
        tab = '󰞔 ',
        C = '^',
        M = 'M-',
      },
    },
    show_help = false, -- show a help message in the command line
    show_keys = false, -- show pressed key and its label in the command line
    -- which-key automatically sets up triggers for your mappings.
    -- but you can disable this and setup the triggers yourself.
    -- triggers are not needed for visual and operator pending mode.
    triggers = {
      { '<auto>', mode = 'nixsotc' }
    },
    disable = {
      -- disable WhichKey for certain buf types and file types.
      ft = {},
      bt = {},
    },
  }
end

M.config = function(_, setup)
  local which_key = require('which-key')
  local utils = require('custom.plugins.utils.fn')
  which_key.setup(setup)

  which_key.add({
    { '<leader>',   group = 'Leader' },
    { '<leader>E',  '<cmd>Vifm<CR>',                   desc = 'Vifm' },
    { '<leader>e',  '<cmd>NvimTreeToggle<CR>',         desc = 'File tree' },
    { '<leader>h',  '<C-w>h',                          desc = 'Left split' },
    { '<leader>j',  '<C-w>j',                          desc = 'Lower split' },
    { '<leader>k',  '<C-w>k',                          desc = 'Upper split' },
    { '<leader>l',  '<C-w>l',                          desc = 'Right split' },

    { '<leader>b',  group = 'Buffer' },
    { '<leader>bb', '<cmd>Telescope buffers<CR>',      desc = 'Open Buffers' },
    { '<leader>br', '<cmd>Telescope oldfiles<cr>',     desc = 'Recent Files' },
    { '<leader>bs', '<cmd>ScratchPad<cr>',             desc = 'Scratch Pad' },
    { '<leader>bu', '<cmd>UndotreeToggle<cr>',         desc = 'Undo Tree' },

    { '<leader>g',  group = 'Git Stuff' },
    { '<leader>gf', '<cmd>Telescope git_files<CR>',    desc = 'Git Files' },
    { '<leader>gg', '<cmd>LazyGit<cr>',                desc = 'LazyGit' },
    { '<leader>gs', '<cmd>Telescope git_status<cr>',   desc = 'Git status' },
    { '<leader>gb', '<cmd>Telescope git_branches<cr>', desc = 'Branches' },
    {
      '<leader>gc',
      '<cmd>Telescope git_bcommits prompt_title=File\\ History<cr>',
      desc = 'File Commits'
    },
    {
      '<leader>gB',
      "<cmd>lua require('gitsigns').blame_line()<cr>",
      desc = 'Blame line'
    },
    {
      '<leader>gC',
      '<cmd>Telescope git_commits prompt_title=Git\\ History<cr>',
      desc = 'Commits'
    },
    {
      '<leader>gG',
      '<cmd>Gitsigns<cr>',
      desc = 'GitSigns menu'
    },
    {
      '<leader>gp',
      "<cmd>lua require('gitsigns').preview_hunk()<cr>",
      desc = 'Preview hunk'
    },
    {
      '<leader>gP',
      "<cmd>lua require('gitsigns').preview_hunk_inline()<cr>",
      desc = 'Preview hunk inline'
    },
    {
      '<leader>gr',
      "<cmd>lua require('gitsigns').reset_hunk()<cr>",
      desc = 'Reset hunk'
    },
    {
      '<leader>gR',
      "<cmd>lua require('gitsigns').reset_buffer()<cr>",
      desc = 'Reset buffer'
    },
    {
      '<leader>gS',
      "<cmd>lua require('gitsigns').stage_hunk()<cr>",
      desc = 'Stage hunk'
    },
    {
      '<leader>gU',
      "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>",
      desc = 'Undo stage hunk'
    },
    {
      '<leader>gd',
      "<cmd>lua require('gitsigns').diffthis()<cr>",
      desc = 'File diff'
    },

    { '<leader>o',  group = 'Open' },
    { '<leader>oL', '<cmd>Lazy<cr>',                desc = 'Lazy' },
    { '<leader>ol', '<cmd>LspInfo<cr>',             desc = 'LspInfo' },
    { '<leader>om', '<cmd>Mason<cr>',               desc = 'Mason' },

    { '<leader>q',  group = 'QuickFix' },
    { '<leader>qq', '<cmd>copen<cr>',               desc = 'QuickFix List' },
    { '<leader>qT', '<cmd>TodoTrouble<cr>',         desc = 'Todos' },
    { '<leader>qd', '<cmd>Trouble diagnostics<cr>', desc = 'Diagnostics' },
    { '<leader>qg', '<cmd>Gitsigns setqflist<cr>',  desc = 'Git Hunks' },
    {
      '<leader>qi',
      '<cmd>Trouble lsp_implementations<cr>',
      desc = 'Implementations'
    },
    {
      '<leader>qs',
      '<cmd>Trouble lsp_document_symbols<cr>',
      desc = 'File Symbols'
    },
    {
      '<leader>qt',
      '<cmd>Trouble lsp_type_definitions<cr>',
      desc = 'Type Definitions'
    },

    { '<leader>s',  group = 'Search' },
    { '<leader>sc', '<cmd>Telescope commands<cr>',    desc = 'Commands' },
    { '<leader>sC', '<cmd>Telescope colorscheme<cr>', desc = 'Colorscheme' },
    { '<leader>sh', '<cmd>Telescope help_tags<cr>',   desc = 'Find Help' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>',     desc = 'Keymaps' },
    { '<leader>sm', '<cmd>Telescope man_pages<cr>',   desc = 'Man Pages' },
    { '<leader>sr', '<cmd>Telescope registers<cr>',   desc = 'Registers' },
    {
      '<leader>ss',
      '<cmd>Telescope live_grep<CR>',
      desc = 'Search in Workspace'
    },
    {
      '<leader>sw',
      function() utils.search_string(vim.fn.expand('<cword>')) end,
      desc = 'Find word Under Cursor'
    },
    {
      '<leader>sW',
      function() utils.search_string(vim.fn.expand('<cWORD>')) end,
      desc = 'Find WORD Under Cursor'
    },
    {
      '<leader>sf',
      '<cmd>Telescope find_files hidden=truelayout_config={previewer=true}<CR>',
      desc = 'Find files'
    },

    { '<leader>t',  group = 'Toggle' },
    { '<leader>tC', '<cmd>ColorColumnToggle<cr>',     desc = 'Color Column' },
    { '<leader>tb', '<cmd>BlanklineToggle<cr>',       desc = 'Blankline' },
    { '<leader>tc', '<cmd>ColorizerToggle<cr>',       desc = 'Colorizer' },
    { '<leader>td', '<cmd>DiagnosticsToggle<cr>',     desc = 'Diagnostics' },
    { '<leader>tf', '<cmd>FormatOnSaveToggle<cr>',    desc = 'Format on Save' },
    { '<leader>tg', '<cmd>Gitsigns toggle_signs<cr>', desc = 'Gitsigns' },
    { '<leader>th', '<cmd>InlayhintsToggle<cr>',      desc = 'Inlay hints' },
    { '<leader>ts', '<cmd>ScrollbarToggle<cr>',       desc = 'Scrollbar' },
    {
      '<leader>tB',
      '<cmd>Gitsigns toggle_current_line_blame<cr>',
      desc = 'Git Blame'
    },
    {
      '<leader>tT',
      '<cmd>TSToggle highlight<cr>',
      desc = 'Treesitter highlight'
    },
    {
      '<leader>to',
      utils.toggle_opacity,
      desc = 'Background Opacity'
    },
    {
      '<leader>tt',
      '<cmd>TSContextToggle<cr>',
      desc = 'Treesitter context'
    },
    {
      '<leader>s',
      utils.search_selection,
      desc = 'Search visual selection',
      mode = 'v'
    },

    { '<C-k>', group = 'Control-K' },
    {
      mode = { 'n' },
      { '<C-k><C-x>', '<cmd>1,$bd!<CR>',  desc = 'Delete All Buffers' },
      { '<C-k>l',     utils.set_filetype, desc = 'Set Filetype' },
      {
        '<C-k>x',
        '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>',
        desc = 'Delete Buffer'
      },
    }
  })
end

return M
