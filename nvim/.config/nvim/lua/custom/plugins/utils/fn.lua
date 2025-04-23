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

  require('fzf-lua').fzf_exec(line_hist_cmd, {
    preview = 'git show --color {1} -- ' .. file,
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
  if vim.gg.opacity then
    vim.gg.opacity = false
    vim.system(
      { 'alacritty', 'msg', 'config', 'window.opacity=1' },
      { text = true }
    )
  else
    vim.gg.opacity = true
    vim.system(
      { 'alacritty', 'msg', 'config', 'window.opacity=0.75' },
      { text = true }
    )
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

return M;
