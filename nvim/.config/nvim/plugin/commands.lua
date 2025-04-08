----------- Custom User Commands ------------
local augroup = vim.api.nvim_create_augroup('customcmd', { clear = true })
vim.api.nvim_create_user_command('W', 'write', {})

vim.api.nvim_create_user_command(
  'Format',
  function(cmd)
    local ms = (#cmd.args > 0 and tonumber(cmd.args)) and
        tonumber(cmd.args) or 30000
    vim.lsp.buf.format({ timeout_ms = ms })
  end,
  { nargs = '?' }
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
  callback = function(opts)
    local is_valid = vim.api.nvim_buf_is_valid(opts.buf)
    if is_valid then vim.api.nvim_input('<esc>') end
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
      'dapui_watches', 'dapui_console', 'dap-repl',
      'Avante', 'AvanteSelectedFiles',
      'AvanteInput', 'AvantePromptInput',
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
  pattern = {
    'qf', 'help', 'man', 'netrw', 'gitsigns-blame',
    'markdown', 'checkhealth',
  },
  callback = function(opt)
    local opts = { noremap = true, silent = true, nowait = true };
    if opt.match == 'qf' or opt.match == 'help' or vim.bo.buftype == 'help' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>bd<cr>', opts)
      vim.api.nvim_set_option_value('number', true, { win = 0 })
      vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
    elseif opt.match == 'man' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>bd<cr>', opts)
    elseif opt.match == 'netrw' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'Q', '<cmd>q<cr>', opts)
    elseif opt.match == 'gitsigns-blame' then
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<cr>', opts)
    elseif opt.match == 'checkhealth' then
      vim.api.nvim_create_autocmd({ 'BufLeave' }, {
        buffer = 0,
        callback = function()
          require('snacks').bufdelete.delete(0)
          vim.cmd.tabclose()
        end
      })
    end
  end,
  group = augroup
})

local prev = { new_name = '', old_name = '' } -- Prevents duplicate events
vim.api.nvim_create_autocmd('User', {
  pattern = 'NvimTreeSetup',
  callback = function()
    local events = require('nvim-tree.api').events
    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        data = data
        require('snacks').rename.on_rename_file(data.old_name, data.new_name)
      end
    end)
  end,
})
