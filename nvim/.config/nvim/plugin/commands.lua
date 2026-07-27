----------- Custom User Commands ------------
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
local augroup = vim.api.nvim_create_augroup('customcmd', { clear = true })

-- highlight text on yank
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  callback = function() vim.hl.on_yank({ timeout = 200 }) end,
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
  group = augroup,
  callback = function()
    vim.api.nvim_set_option_value('number', false, { win = 0 })
    vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
    vim.api.nvim_set_option_value('signcolumn', 'no', { win = 0 })
    vim.keymap.set({ 't' }, 'ii', [[<C-\><C-n>]], { silent = true, buf = 0 })
    vim.cmd.startinsert()
  end
})

vim.api.nvim_create_autocmd({ 'TermClose' }, {
  group = augroup,
  callback = function(opts)
    local is_valid = vim.api.nvim_buf_is_valid(opts.buf)
    if is_valid then vim.api.nvim_input('<esc>') end
  end
})

-- set absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  group = augroup,
  callback = function()
    if vim.o.relativenumber then
      vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
    end
  end,
})

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  group = augroup,
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
})

local keymap_opts = { noremap = true, silent = true, nowait = true };
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'qf', 'help' },
  group = augroup,
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>bd<cr>', keymap_opts)
    vim.api.nvim_set_option_value('number', true, { win = 0 })
    vim.api.nvim_set_option_value('statuscolumn', ' %l  ', { win = 0 })
    vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
    vim.api.nvim_set_option_value('wrap', false, { win = 0 })
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'man',
  group = augroup,
  callback = function()
    vim.api.nvim_set_option_value('number', true, { win = 0 })
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>bd<cr>', keymap_opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>tw', '<cmd>WrapMarginToggle<cr>', keymap_opts)
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'gitsigns-blame',
  group = augroup,
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<cr>', keymap_opts)
  end,
})

