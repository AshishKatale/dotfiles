M = {}

M.search_string = function(text)
  require('fzf-lua').live_grep({
    search = text,
    hidden = true
  })
end

M.find_in_dir = function(cwd_path, dirname)
  require('fzf-lua').live_grep({
    cwd = cwd_path,
    hidden = true,
    ['winopts.title'] = ' Find in [' .. dirname .. '] ',
  })
end

M.show_line_history = function()
  local line          = vim.api.nvim_win_get_cursor(0)[1]
  local file          = vim.api.nvim_buf_get_name(0)
  local git_root      = vim.trim(
    vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true })
    :wait().stdout
  )

  local line_hist_cmd = [[git -C ]] .. git_root .. [[ log --color --pretty=format:]] ..
      [['%C(yellow)%h%Creset %s %C(magenta)%cr%Creset %C(blue)<%an>%Creset']] ..
      [[ -s -L ]] .. line .. [[,+1:]] .. file

  local fzflua        = require('fzf-lua')
  fzflua.fzf_exec(line_hist_cmd, {
    preview = 'git show --color {1} -- ' .. file,
    actions = {
      ['enter']  = fzflua.actions.git_buf_edit,
      ['ctrl-x'] = fzflua.actions.git_buf_split,
      ['ctrl-v'] = fzflua.actions.git_buf_vsplit,
      ['ctrl-y'] = {
        reload = true,
        desc = 'git-yank-commit',
        fn = function(selected)
          local hash = vim.split(selected[1], ' ')[1]
          vim.fn.setreg('"', hash)
          vim.notify('yanked commit hash: ' .. hash)
        end,
      },
    },
    winopts = {
      title = ' Line history '
    }
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

M.toggle_opacity = function()
  local is_alacritty = vim.env.ALACRITTY_WINDOW_ID
  if is_alacritty then
    if vim.gg.opacity then
      vim.system({ 'alacritty', 'msg', 'config', '--window-id=-1', 'window.opacity=1' },
        { text = true })
      vim.gg.opacity = false
    else
      vim.system({ 'alacritty', 'msg', 'config', '--window-id=-1', 'window.opacity=0.75' },
        { text = true })
      vim.gg.opacity = true
    end
  else
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

M.toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

M.toggle_diagnostic = function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

M.toggle_color_column = function()
  local colorcolumn = tonumber(vim.api.nvim_get_option_value('colorcolumn', {
    scope = 'local'
  }))
  if colorcolumn and colorcolumn > 0 then
    vim.api.nvim_set_option_value('colorcolumn', '', { scope = 'local' })
  else
    vim.api.nvim_set_option_value('colorcolumn', '81', { scope = 'local' })
  end
end

M.toggle_indent_guides = function()
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
    title = ' Scratch Pad ',
    title_pos = 'right',
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

return M;
