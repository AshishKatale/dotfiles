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
    { '<leader>h',  '<C-w>h',        desc = 'Left split' },
    { '<leader>j',  '<C-w>j',        desc = 'Lower split' },
    { '<leader>k',  '<C-w>k',        desc = 'Upper split' },
    { '<leader>l',  '<C-w>l',        desc = 'Right split' },
    { '<leader>|',  '<cmd>vnew<cr>', desc = 'New buffer right' },
    { '<leader>_',  '<cmd>new<cr>',  desc = 'New buffer bottom' },
    { '<leader>\\', '<cmd>enew<cr>', desc = 'New buffer' },
    {
      '<leader>e',
      function() require('snacks').picker.explorer() end,
      desc = 'File tree'
    },
    {
      '<leader>E',
      function() utils.toggle_term('float', 'vifm', ' Vifm ') end,
      desc = 'Vifm'
    },

    { '<leader>b',  group = 'Buffer' },
    { '<leader>b ', '<cmd>%s/\\s\\+$//e<cr>',  desc = 'Trim trailing spaces' },
    { '<leader>bu', '<cmd>UndotreeToggle<cr>', desc = 'Undo Tree' },
    { '<leader>by', '<cmd>%y<cr>',             desc = 'Yank buffer' },
    { '<leader>bY', '<cmd>%y+<cr>',            desc = 'Copy buffer' },
    { '<leader>bb', utils.scratch_buffer,      desc = 'Scratch Pad' },
    {
      '<leader>bf',
      function() require('snacks').picker.buffers() end,
      desc = 'Open Buffers'
    },

    { '<leader>o',  group = 'Open' },
    { '<leader>oz', '<cmd>Lazy<cr>',                   desc = 'Lazy' },
    { '<leader>ol', '<cmd>checkhealth vim.lsp<cr>',    desc = 'LspInfo' },
    { '<leader>om', '<cmd>Mason<cr>',                  desc = 'Mason' },

    { '<leader>q',  group = 'QuickFix' },
    { '<leader>qq', '<cmd>copen<cr>',                  desc = 'QuickFix List' },
    { '<leader>qf', '<cmd>Trouble qflist<cr>',         desc = 'Trouble QfList' },
    { '<leader>qp', '<cmd>cprev<cr>',                  desc = 'QuickFix Prev' },
    { '<leader>qn', '<cmd>cnext<cr>',                  desc = 'QuickFix Next' },
    { '<leader>q0', '<cmd>cfirst<cr>',                 desc = 'QuickFix First' },
    { '<leader>q$', '<cmd>clast<cr>',                  desc = 'QuickFix Last' },
    { '<leader>qt', '<cmd>TodoTrouble<cr>',            desc = 'Todos' },
    { '<leader>qd', '<cmd>Trouble diagnostics<cr>',    desc = 'Diagnostics' },
    { '<leader>qg', '<cmd>Gitsigns setqflist<cr>',     desc = 'Git Hunks' },
    { '<leader>qr', '<cmd>Trouble lsp_references<cr>', desc = 'LSP references' },
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
    {
      '<leader>sb',
      function() require('snacks').picker.grep_buffers() end,
      desc = 'Search in Buffers'
    },
    {
      '<leader>sc',
      function() require('snacks').picker.commands() end,
      desc = 'Commands'
    },
    {
      '<leader>sC',
      function() require('snacks').picker.colorschemes() end,
      desc = 'Colorscheme'
    },
    {
      '<leader>sd',
      function() require('snacks').picker.diagnostics_buffer() end,
      desc = 'Diagnostics Buffer'
    },
    {
      '<leader>sD',
      function() require('snacks').picker.diagnostics() end,
      desc = 'Diagnostics Workspace'
    },
    {
      '<leader>si',
      function() require('snacks').picker.icons() end,
      desc = 'Find Icons'
    },
    {
      '<leader>s\'',
      function() require('snacks').picker.marks() end,
      desc = 'Find Marks'
    },
    {
      '<leader>sH',
      function() require('snacks').picker.highlights() end,
      desc = 'HL Groups'
    },
    {
      '<leader>sk',
      function() require('snacks').picker.keymaps() end,
      desc = 'Keymaps'
    },
    { '<leader>sm', '<cmd>Man<cr>',  desc = 'Man Pages' },
    {
      '<leader>sM',
      function() require('snacks').picker.man() end,
      desc = 'Find Manpage'
    },
    {
      '<leader>sr',
      function() require('snacks').picker.lsp_references() end,
      desc = 'LSP References'
    },
    {
      '<leader>sg',
      function() require('snacks').picker.git_grep({ hidden = true }) end,
      desc = 'Search Git Files'
    },
    {
      '<leader>ss',
      function() require('snacks').picker.grep({ hidden = true }) end,
      desc = 'Search in Workspace'
    },
    {
      '<leader>sp',
      function() require('snacks').picker.pickers() end,
      desc = 'Select Picker'
    },
    {
      '<leader>so',
      function() require('snacks').picker.recent() end,
      desc = 'Select Picker'
    },
    {
      '<leader>sh',
      function() require('snacks').picker.help() end,
      desc = 'Find HelpTags'
    },
    {
      '<leader>sz',
      function() require('snacks').picker.resume() end,
      desc = 'Resume Picker'
    },
    {
      '<leader>sw',
      function() utils.search_string(vim.fn.expand('<cword>')) end,
      desc = 'Find cword'
    },
    {
      '<leader>sW',
      function() utils.search_string(vim.fn.expand('<cWORD>')) end,
      desc = 'Find cWORD'
    },
    {
      '<leader>s',
      utils.search_selection,
      desc = 'Search visual selection',
      mode = 'v'
    },

    { '<leader>t',  group = 'Toggle' },
    { '<leader>tw', '<cmd>set wrap!<cr>',             desc = 'Line wrap' },
    { '<leader>tm', '<cmd>set showmode!<cr>',         desc = 'Show mode' },
    { '<leader>ts', '<cmd>set spell!<cr>',            desc = 'Spell check' },
    { '<leader>tf', '<cmd>set foldenable!<cr>',       desc = 'Folding' },
    { '<leader>tc', '<cmd>ColorizerToggle<cr>',       desc = 'Colorizer' },
    { '<leader>tg', '<cmd>Gitsigns toggle_signs<cr>', desc = 'Gitsigns' },
    { '<leader>tH', '<cmd>TSToggle highlight<cr>',    desc = 'Treesitter highlight' },
    { '<leader>th', utils.toggle_inlay_hints,         desc = 'Inlay hints' },
    { '<leader>td', utils.toggle_diagnostic,          desc = 'Diagnostics' },
    { '<leader>to', utils.toggle_opacity,             desc = 'Background opacity' },
    { '<leader>ti', utils.toggle_indent_guides,       desc = 'Indent guides' },
    { '<leader>tl', utils.toggle_list_chars,          desc = 'List chars' },
    { '<leader>tn', utils.toggle_number,              desc = 'Line numbers' },
    { '<leader>tF', utils.toggle_format_on_save,      desc = 'Format on Save' },
    { '<leader>tC', utils.toggle_color_column,        desc = 'Color column' },
    {
      '<leader>tt',
      function() require('treesitter-context').toggle() end,
      desc = 'Treesitter context'
    },
    {
      '<leader>tb',
      '<cmd>Gitsigns toggle_current_line_blame<cr>',
      desc = 'Git Blame'
    },

    { '<leader>zz',      '<cmd>lua Snacks.zen()<cr>',     desc = 'Zen mode' },

    { '<localleader>',   group = 'Local Leader' },
    { '<localleader>\\', '<cmd>tabnew term://$SHELL<cr>', desc = 'Terminal tab' },
    {
      '<localleader>-',
      function() utils.toggle_term('float') end,
      desc = 'Terminal bottom'
    },
    {
      '<localleader>_',
      function() utils.toggle_term('bottom') end,
      desc = 'Terminal bottom'
    },
    {
      '<localleader>|',
      function() utils.toggle_term('right') end,
      desc = 'Terminal bottom'
    },

    { '<C-k>', group = 'Control-K' },
    {
      mode = { 'n' },
      { '<C-k>l', utils.set_filetype, desc = 'Set Filetype' },
      {
        '<C-k><C-x>',
        function() require('snacks').bufdelete.all() end,
        desc = 'Delete All Buffers'
      },
      {
        '<C-k>X',
        function() require('snacks').bufdelete.other() end,
        desc = 'Delete All Other Buffers'
      },
      {
        '<C-k>x',
        function() require('snacks').bufdelete.delete() end,
        desc = 'Delete Buffer'
      },
    }
  })
end

return M
