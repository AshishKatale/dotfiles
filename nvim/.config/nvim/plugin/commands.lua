----------- Custom User Commands ------------
local augroup = vim.api.nvim_create_augroup('customcmd', { clear = true })

vim.api.nvim_create_user_command(
  'LazyGit',
  function()
    local is_git_repo = vim.system(
      { 'git', 'rev-parse', '--is-inside-work-tree' },
      { text = true }
    ):wait().code == 0
    if is_git_repo then
      vim.cmd('tabnew term://lazygit')
      vim.keymap.set({ 't' }, 'ii', '<Nop>', { silent = true, buffer = 0 })
      vim.keymap.set(
        { 't' }, '<C-\\>', [[<C-\><C-n>0M]],
        { silent = true, buffer = 0 }
      )
    else
      vim.notify('Error: lazygit must be run inside a git repository')
    end
  end,
  {}
)

vim.api.nvim_create_user_command(
  'Vifm',
  function() vim.cmd('tabnew term://vifm') end,
  {}
)

vim.api.nvim_create_user_command(
  'Format',
  function() vim.lsp.buf.format({ timeout_ms = 30000 }) end,
  {}
)

vim.api.nvim_create_user_command(
  'BlanklineToggle',
  function()
    vim.cmd('IBLToggle')
    if not vim.gg.listchars then
      vim.opt.listchars:append('eol:↲') -- render eol as ↴
      vim.opt.listchars:append('tab:→ ') -- render tab as →
      vim.opt.listchars:append('lead:·') -- render space as ·
      vim.gg.listchars = true
    else
      vim.opt.listchars:remove('eol')
      vim.opt.listchars:remove('tab')
      vim.opt.listchars:remove('lead')
      vim.opt.listchars:append('tab:  ')
      vim.gg.listchars = false
    end
  end,
  {}
)

vim.api.nvim_create_user_command(
  'DiagnosticsToggle',
  function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
  {}
)

vim.api.nvim_create_user_command(
  'InlayhintsToggle',
  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  {}
)

vim.api.nvim_create_user_command('ScratchPad', function()
    local function set_opts()
      local win = vim.gg.scratch.win
      vim.api.nvim_set_option_value('number', true, { win = win })
      vim.api.nvim_set_option_value('relativenumber', true, { win = win })
      vim.api.nvim_set_option_value('cursorline', true, { win = win })
      vim.api.nvim_set_option_value('signcolumn', 'yes', { win = win })
      vim.api.nvim_set_option_value('conceallevel', 0, { win = win })
    end
    if vim.gg.scratch and
        (vim.gg.scratch:win_valid() or vim.gg.scratch:buf_valid()) then
      vim.gg.scratch:toggle()
      set_opts()
    else
      vim.gg.scratch = require('lazy.util').float({
        title = ' Scratch Pad ─',
        title_pos = 'right',
        persistent = true,
        interactive = true
      })
      vim.api.nvim_set_option_value('filetype', 'text', {
        buf = vim.gg.scratch.buf
      })
      set_opts()
    end
  end,
  {}
)

vim.api.nvim_create_user_command('FloatTerm', function(cmd)
  if #cmd.fargs > 0 then
    require('lazy.util').float_term(cmd.fargs, {})
  elseif vim.gg.term and
      (vim.gg.term:win_valid() or vim.gg.term:buf_valid()) then
    vim.gg.term:toggle()
  else
    vim.gg.term = require('lazy.util').float_term(nil, {
      persistent = true,
      interactive = true
    })
    vim.api.nvim_create_autocmd('BufEnter', {
      buffer = vim.gg.term.buf,
      callback = function() vim.cmd.startinsert() end,
    })
  end
end, {
  nargs = '*',
  complete = function(cmd)
    local cmds = { 'btop', 'top', 'git log --oneline', 'lazygit' }
    return vim.tbl_filter(
      function(c) return string.find(c, cmd) end,
      cmds
    )
  end,
})

vim.api.nvim_create_user_command('ColorColumnToggle', function()
  local colorcolumn = tonumber(vim.api.nvim_get_option_value('colorcolumn', {
    scope = 'local'
  }))
  if colorcolumn and colorcolumn > 0 then
    vim.api.nvim_set_option_value('colorcolumn', '', { scope = 'local' })
  else
    vim.api.nvim_set_option_value('colorcolumn', '81', { scope = 'local' })
  end
end, {})

vim.g.format_on_save_cmd = nil
vim.api.nvim_create_user_command(
  'FormatOnSaveToggle',
  function()
    if vim.g.format_on_save_cmd ~= nil then
      vim.api.nvim_del_autocmd(vim.g.format_on_save_cmd)
      vim.g.format_on_save_cmd = nil
    else
      vim.g.format_on_save_cmd = vim.api.nvim_create_autocmd('BufWritePost', {
        group = augroup,
        callback = function()
          vim.lsp.buf.format({ async = true })
        end,
      })
    end
  end,
  {}
)

------------ Custom AutoCommands ------------

-- highlight text on yank
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
  group = augroup
})

vim.api.nvim_create_autocmd({ 'CursorHold' }, {
  pattern = { 'query_editor.scm' },
  callback = function() vim.diagnostic.open_float() end,
  group = augroup
})

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove('o')
  end
})

-- reset cursor style to underline before exiting
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  callback = function() vim.opt.guicursor = 'a:hor20' end,
  group = augroup
})

vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  callback = function()
    vim.api.nvim_set_option_value('number', false, { win = 0 })
    vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
    vim.api.nvim_set_option_value('signcolumn', 'no', { win = 0 })
    vim.cmd.startinsert()
  end,
  group = augroup
})

vim.api.nvim_create_autocmd({ 'TermClose' }, {
  callback = function()
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes('<CR>', true, true, true),
      'n',
      true
    )
  end,
  group = augroup
})

-- set absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  callback = function()
    vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
  end,
  group = augroup
})

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  callback = function()
    if vim.bo.filetype == 'trouble' or
        vim.bo.filetype == 'lazy' or
        vim.bo.filetype == 'help' or
        vim.bo.filetype == 'startup' or
        vim.bo.filetype == 'TelescopePrompt' or
        vim.bo.filetype == 'DressingInput' or
        vim.bo.filetype == 'NvimTree'
    then
      return
    end
    vim.api.nvim_set_option_value('relativenumber', true, { win = 0 })
  end,
  group = augroup
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'qf', 'help', 'netrw', 'gitsigns-blame' },
  callback = function(opt)
    local opts = { noremap = true, silent = true, nowait = true };
    if opt.match == 'qf' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'l', '<cr>', { noremap = true })
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', opts)
    elseif opt.match == 'help' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', opts)
      vim.api.nvim_set_option_value('number', true, { win = 0 })
      vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
    elseif opt.match == 'netrw' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'Q', '<cmd>q<CR>', opts)
    elseif opt.match == 'gitsigns-blame' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', opts)
    end
  end,
  group = augroup
})
