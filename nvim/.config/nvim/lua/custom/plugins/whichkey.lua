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
      row = -1,
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
    { '<leader>E',  '<cmd>FloatTerm vifm<cr>',      desc = 'Vifm' },
    { '<leader>e',  '<cmd>NvimTreeToggle<cr>',      desc = 'File tree' },
    { '<leader>h',  '<C-w>h',                       desc = 'Left split' },
    { '<leader>j',  '<C-w>j',                       desc = 'Lower split' },
    { '<leader>k',  '<C-w>k',                       desc = 'Upper split' },
    { '<leader>l',  '<C-w>l',                       desc = 'Right split' },
    { '<leader>|',  '<cmd>vnew<cr>',                desc = 'Split right' },
    { '<leader>_',  '<cmd>new<cr>',                 desc = 'Split bottom' },

    { '<leader>b',  group = 'Buffer' },
    { '<leader>b ', '<cmd>%s/\\s\\+$//e<cr>',       desc = 'Remove trailing' },
    { '<leader>bf', '<cmd>FzfLua buffers<cr>',      desc = 'Open Buffers' },
    { '<leader>bo', '<cmd>FzfLua oldfiles<cr>',     desc = 'Old Files' },
    { '<leader>bu', '<cmd>UndotreeToggle<cr>',      desc = 'Undo Tree' },
    { '<leader>by', '<cmd>%y<cr>',                  desc = 'Yank buffer' },
    { '<leader>bY', '<cmd>%y+<cr>',                 desc = 'Copy buffer' },
    { '<leader>bb', utils.scratch_buffer,           desc = 'Scratch Pad' },

    { '<leader>d',  group = 'Debug' },
    { '<leader>dd', '<cmd>DapContinue<cr>',         desc = 'DAP Continue' },
    { '<leader>db', '<cmd>DapToggleBreakpoint<cr>', desc = 'Breakpoint' },

    { '<leader>g',  group = 'Git' },
    { '<leader>gg', utils.lazy_git,                 desc = 'LazyGit' },
    { '<leader>gf', '<cmd>FzfLua git_files<cr>',    desc = 'Git Files' },
    { '<leader>gs', '<cmd>FzfLua git_status<cr>',   desc = 'Git status' },
    { '<leader>gb', '<cmd>FzfLua git_branches<cr>', desc = 'Branches' },
    { '<leader>gl', utils.show_line_history,        desc = 'Git line history' },
    {
      '<leader>gc',
      [[<cmd>FzfLua git_commits winopts.title=\ Git\ log\ <cr>]],
      desc = 'Git commit log'
    },
    {
      '<leader>gh',
      [[<cmd>FzfLua git_bcommits winopts.title=\ File\ history\ <cr>]],
      desc = 'File history'
    },
    {
      '<leader>gB',
      "<cmd>lua require('gitsigns').blame()<cr>",
      desc = 'Blame'
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
    { '<leader>ol', '<cmd>checkhealth vim.lsp<cr>', desc = 'LspInfo' },
    { '<leader>om', '<cmd>Mason<cr>',               desc = 'Mason' },

    { '<leader>q',  group = 'QuickFix' },
    { '<leader>qf', '<cmd>Trouble qflist<cr>',      desc = 'Trouble QfList' },
    { '<leader>qp', '<cmd>cprev<cr>',               desc = 'QuickFix Prev' },
    { '<leader>qn', '<cmd>cnext<cr>',               desc = 'QuickFix Next' },
    { '<leader>q0', '<cmd>cfirst<cr>',              desc = 'QuickFix First' },
    { '<leader>q$', '<cmd>clast<cr>',               desc = 'QuickFix Last' },
    { '<leader>qt', '<cmd>TodoTrouble<cr>',         desc = 'Todos' },
    { '<leader>qd', '<cmd>Trouble diagnostics<cr>', desc = 'Diagnostics' },
    { '<leader>qg', '<cmd>Gitsigns setqflist<cr>',  desc = 'Git Hunks' },
    {
      '<leader>qq',
      function()
        require('nvim-tree.api').tree.close()
        vim.cmd('copen')
      end,
      desc = 'QuickFix List'
    },
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
      '<leader>qT',
      '<cmd>Trouble lsp_type_definitions<cr>',
      desc = 'Type Definitions'
    },

    { '<leader>s',  group = 'Search' },
    { '<leader>sc', '<cmd>FzfLua commands<cr>',     desc = 'Commands' },
    { '<leader>sC', '<cmd>FzfLua colorscheme<cr>',  desc = 'Colorscheme' },
    { '<leader>sh', '<cmd>FzfLua helptags<cr>',     desc = 'Find Help' },
    { '<leader>sH', '<cmd>FzfLua highlights<cr>',   desc = 'HL Groups' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>',      desc = 'Keymaps' },
    { '<leader>sm', '<cmd>Man<cr>',                 desc = 'Man Pages' },
    { '<leader>sM', '<cmd>FzfLua manpages<cr>',     desc = 'FzfLua Man' },
    { '<leader>sr', '<cmd>FzfLua registers<cr>',    desc = 'Registers' },
    { '<leader>so', '<cmd>FzfLua nvim_options<cr>', desc = 'Vim Options' },
    {
      '<leader>ss',
      '<cmd>FzfLua live_grep<cr>',
      desc = 'Search Workspace'
    },
    {
      '<leader>sg',
      '<cmd>FzfLua live_grep_glob<cr>',
      desc = 'Glob search Workspace'
    },
    {
      '<leader>sf',
      '<cmd>FzfLua grep<cr>',
      desc = 'Glob search Workspace'
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
      '<leader>s',
      utils.search_selection,
      desc = 'Search visual selection',
      mode = 'v'
    },

    { '<leader>t',  group = 'Toggle' },
    { '<leader>tw', '<cmd>set wrap!<cr>',             desc = 'Line wrap' },
    { '<leader>tm', '<cmd>RenderMarkdown toggle<cr>', desc = 'Render markdown' },
    { '<leader>tM', '<cmd>set showmode!<cr>',         desc = 'Show mode' },
    { '<leader>ts', '<cmd>set spell!<cr>',            desc = 'Spell check' },
    { '<leader>tc', '<cmd>ColorizerToggle<cr>',       desc = 'Colorizer' },
    { '<leader>tg', '<cmd>Gitsigns toggle_signs<cr>', desc = 'Gitsigns' },
    { '<leader>tt', '<cmd>TSContextToggle<cr>',       desc = 'Treesitter context' },
    { '<leader>tT', '<cmd>TSToggle highlight<cr>',    desc = 'Treesitter highlight' },
    { '<leader>tf', '<cmd>set foldenable!<cr>',       desc = 'Folding' },
    { '<leader>tF', utils.toggle_format_on_save,      desc = 'Format on Save' },
    { '<leader>tC', utils.toggle_color_column,        desc = 'Color Column' },
    { '<leader>tb', utils.toggle_indent_guides,       desc = 'Blankline' },
    { '<leader>td', utils.toggle_diagnostic,          desc = 'Diagnostics' },
    { '<leader>th', utils.toggle_inlay_hints,         desc = 'Inlay hints' },
    { '<leader>to', utils.toggle_opacity,             desc = 'Background Opacity' },
    {
      '<leader>tB',
      '<cmd>Gitsigns toggle_current_line_blame<cr>',
      desc = 'Git Blame'
    },

    { '<leader>zz',    '<cmd>lua Snacks.zen()<cr>', desc = 'Zen mode' },

    { '<localleader>', group = 'Local Leader' },
    {
      '<localleader><localleader>',
      '<cmd>tabnew term://$SHELL<cr>',
      desc = 'Terminal tab'
    },
    {
      '<localleader>_',
      '<cmd>new term://$SHELL<cr>',
      desc = 'Terminal bottom'
    },
    {
      '<localleader>|',
      '<cmd>vnew term://$SHELL<cr>',
      desc = 'Terminal right'
    },

    { '<C-k>', group = 'Control-K' },
    {
      mode = { 'n' },
      { '<C-k><C-x>', '<cmd>1,$bd!<cr>',           desc = 'Delete All Buffers' },
      { '<C-k>l',     '<cmd>FzfLua filetypes<cr>', desc = 'Set Filetype' },
      {
        '<C-k>x',
        '<cmd>bd!<cr>',
        desc = 'Delete Buffer'
      },
    }
  })
end

return M
