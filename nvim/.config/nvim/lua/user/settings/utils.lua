local telescope_builtin_ok, telescope_builtin = pcall(require, "telescope.builtin")
if not telescope_builtin_ok then
  print("Unable to load: settings/utils")
  return
end

M = {}

M.search_string = function(text)
  telescope_builtin.grep_string({
    search = text,
    additional_args = function() return { "--hidden" } end
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
  local filetypes = vim.split(
    vim.fn.system("ls -1 /usr/share/nvim/runtime/syntax | cut -d'.' -f1"),
    "\n"
  )
  table.remove(filetypes, #filetypes)
  vim.ui.select(
    filetypes,
    { prompt = 'Select filetype:' },
    function(choice)
      if choice then
        vim.cmd("set filetype=" .. choice)
        vim.print("filetype set: " .. choice)
      end
    end
  )
end

return M;
