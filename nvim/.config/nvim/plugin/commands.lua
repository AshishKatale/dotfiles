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
      lazy = true,
      help = true,
      trouble = true,
      startup = true,
      ['dap-repl'] = true,
      dapui_scopes = true,
      dapui_stacks = true,
      dapui_watches = true,
      dapui_console = true,
      dapui_breakpoints = true,
      snacks_input = true,
      snacks_dashboard = true,
      snacks_picker_list = true,
      snacks_picker_preview = true,
    }
    if fts[vim.bo.filetype] then return end
    vim.api.nvim_set_option_value('relativenumber', true, { win = 0 })
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
      vim.api.nvim_set_option_value('statuscolumn', ' %l  ', { win = 0 })
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
