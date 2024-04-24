M = {}

M.search_string = function(text)
  require('telescope.builtin').grep_string({
    search = text,
    additional_args = function() return { '--hidden' } end
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

M.set_filetype = function()
  require('telescope.builtin').filetypes(
    require('telescope.themes').get_dropdown {
      previewer = false,
      hidden = true
    }
  )
end

return M;
