M = {}

M.search_string = function(text)
  require('snacks').picker.grep({
    search = text,
    hidden = true
  })
end

M.search_selection = function()
  local sel_start, sel_end = vim.fn.getpos('v'), vim.fn.getpos('.')
  local line_start, col_start = sel_start[2], sel_start[3]
  local line_end, col_end = sel_end[2], sel_end[3]
  if col_end < col_start then
    col_start, col_end = col_end, col_start
  end
  local visual_select = vim.api.nvim_buf_get_text(
    0, line_start - 1, col_start - 1,
    line_end - 1, col_end, {}
  )
  local text = vim.tbl_get(visual_select, 1)
  M.search_string(text)
end

M.range_format = function()
  vim.lsp.buf.format({
    async = true,
    range = {
      ['start'] = vim.api.nvim_buf_get_mark(0, '<'),
      ['end'] = vim.api.nvim_buf_get_mark(0, '>'),
    }
  })
end

M.toggle_term = function(position)
  if not position then
    position = 'float'
  end

  if position == 'float' then
    require('snacks').terminal(nil, {
      auto_close = true,
      win = {
        position = 'float',
        border = 'rounded',
        height = 0.85,
        width = 0.85,
      }
    })
  elseif position == 'bottom' then
    require('snacks').terminal(nil, {
      win = { wo = { winbar = '' } }
    })
  elseif position == 'right' then
    require('snacks').terminal(nil, {
      win = {
        position = 'right',
        wo = { winbar = '' }
      }
    })
  end
end

M.toggle_opacity = function()
  if vim.gg.opacity then
    vim.cmd([[
        hi! Normal guibg=#11111B
        hi! NormalFloat guibg=#11111B
      ]])
    vim.gg.opacity = false
  else
    vim.cmd([[
        hi! Normal guibg=NONE
        hi! NormalFloat guibg=NONE
      ]])
    vim.gg.opacity = true
  end
end

M.toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

M.toggle_diagnostic = function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

M.toggle_color_column = function()
  vim.wo.colorcolumn = (vim.wo.colorcolumn == '81') and '' or '81'
end

M.toggle_number = function()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = not vim.wo.relativenumber
end

M.toggle_indent_guides = function()
  local snacks = require('snacks')
  if snacks.indent.enabled then
    snacks.indent.disable()
  else
    snacks.indent.enable()
  end
end

M.toggle_list_chars = function()
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
end

M.toggle_format_on_save = function()
  if vim.gg.format_on_save_autocmd_id ~= nil then
    vim.api.nvim_del_autocmd(vim.gg.format_on_save_autocmd_id)
    vim.gg.format_on_save_autocmd_id = nil
    vim.notify('Disabled format on save.')
  else
    vim.gg.format_on_save_autocmd_id = vim.api.nvim_create_autocmd('BufWritePost', {
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })
    vim.notify('Enabled format on save.')
  end
end

M.lazy_git = function()
  local is_inside_git_work_tree = vim.system(
    { 'git', 'rev-parse', '--is-inside-work-tree' }, { text = true }
  ):wait().code == 0

  if is_inside_git_work_tree then
    vim.cmd('tabnew term://lazygit')
    vim.keymap.set({ 't' }, 'ii', '<Nop>', { silent = true, buffer = 0 })
    vim.keymap.set(
      { 't' }, [[<C-\>]], [[<C-\><C-n>0M]],
      { silent = true, buffer = 0 }
    )
  else
    vim.notify('Error: lazygit must be run inside a git repository',
      vim.log.levels.ERROR, { history = false })
  end
end

M.scratch_buffer = function()
  if vim.gg.scratch and
      (vim.gg.scratch:win_valid() or vim.gg.scratch:buf_valid()) then
    vim.gg.scratch:toggle()
    return
  end

  vim.gg.scratch = require('snacks').win({
    width = 0.85,
    height = 0.85,
    border = 'rounded',
    title = ' Scratch Buffer ',
    title_pos = 'center',
    fixbuf = true,
    scratch_ft = vim.bo.filetype,
    keys = {
      { '<C-q>', function(self) self:toggle() end,      desc = 'hide' },
      { '<C-_>', function(self) self:toggle_help() end, desc = 'help' },
      {
        '<M-q>',
        function(self) vim.api.nvim_buf_delete(self.buf, { force = true }) end,
        desc = 'close'
      },
    },
    wo = {
      spell = false,
      wrap = false,
      number = true,
      relativenumber = true,
      signcolumn = 'yes',
    },
  })
end

M.set_filetype = function()
  local filetypes = vim.fn.getcompletion('', 'filetype')
  require('snacks').picker.select(filetypes, {
    prompt = 'Set Filetype',
  }, function(choice)
    if not choice then return end
    vim.cmd.setfiletype(choice)
  end)
end

return M;
