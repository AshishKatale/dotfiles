----------- Custom User Commands ------------
local augroup = vim.api.nvim_create_augroup('customcmd', { clear = true })
vim.api.nvim_create_user_command('W', 'write', {})

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
      vim.api.nvim_echo(
        { { 'Error: lazygit must be run inside a git repository' } },
        false, -- don't add to message history
        { err = true }
      )
    end
  end,
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
    local snacks = require('snacks')
    if snacks.indent.enabled then
      snacks.indent.disable()
    else
      snacks.indent.enable()
    end

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
      -- override lazy util keymap
      vim.keymap.set('n', 'q', 'q', { buffer = vim.gg.scratch.buf })
    end
    if vim.gg.scratch and
        (vim.gg.scratch:win_valid() or vim.gg.scratch:buf_valid()) then
      vim.gg.scratch:toggle()
      set_opts()
    else
      vim.gg.scratch = require('lazy.util').float({
        title = ' Scratch Pad ',
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
    return vim.iter(cmds):filter(
      function(c) return string.match(c, cmd) end
    ):totable()
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

vim.api.nvim_create_user_command(
  'FormatOnSaveToggle',
  function()
    if vim.gg.format_on_save_autocmd_id ~= nil then
      vim.api.nvim_del_autocmd(vim.gg.format_on_save_autocmd_id)
      vim.gg.format_on_save_autocmd_id = nil
    else
      vim.gg.format_on_save_autocmd_id = vim.api.nvim_create_autocmd('BufWritePost', {
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
      vim.api.nvim_replace_termcodes('<esc>', true, true, true),
      'n',
      true
    )
  end,
  group = augroup
})

-- set absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  callback = function()
    if vim.o.relativenumber then
      vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
    end
  end,
  group = augroup
})

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  callback = function()
    local fts = {
      'trouble', 'lazy', 'help', 'startup',
      'fzf', 'snacks_input', 'NvimTree',
      'dapui_breakpoints', 'dapui_scopes', 'dapui_stacks',
      'dapui_watches', 'dapui_console', 'dap-repl'
    }
    if vim.iter(fts):any(function(ft)
          return ft == vim.bo.filetype
        end)
    then
      return
    end
    if not vim.o.relativenumber then
      vim.api.nvim_set_option_value('relativenumber', true, { win = 0 })
    end
  end,
  group = augroup
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'qf', 'help', 'man', 'netrw', 'gitsigns-blame' },
  callback = function(opt)
    local opts = { noremap = true, silent = true, nowait = true };
    if opt.match == 'qf' or opt.match == 'help' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>bd<cr>', opts)
      vim.api.nvim_set_option_value('number', true, { win = 0 })
      vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
    elseif opt.match == 'man' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>bd<cr>', opts)
    elseif opt.match == 'netrw' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'Q', '<cmd>q<cr>', opts)
    elseif opt.match == 'gitsigns-blame' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<cr>', opts)
    end
  end,
  group = augroup
})
