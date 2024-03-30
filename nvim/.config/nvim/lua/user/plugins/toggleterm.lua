local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  print("Unable to load: toggleterm")
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.opt.mouse = "v"
  vim.api.nvim_buf_set_keymap(0, "t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  count = 2,
  hidden = true,
  direction = "tab",
  close_on_exit = true,
  on_open = function()
    local output = vim.api.nvim_exec("silent! !git rev-parse --show-toplevel  &> /dev/null;echo $?;", true)
    local lines = {}
    local exit_code
    for i in string.gmatch(output, "[^\r\n]+") do
      table.insert(lines, i)
    end

    for i, v in pairs(lines) do
      if i == 2 then
        exit_code = v
      end
    end

    if exit_code ~= "0" then
      vim.notify("Git repository is not available in the workspace")
    end

    vim.keymap.set({ "t" }, "ii", "", { silent = true, buffer = 0 })
  end,

  -- on_close = function(term) end,
})

local npm_start_runner = Terminal:new({ cmd = "npm start", count = 3, hidden = true })
local npm_dev_runner = Terminal:new({ cmd = "npm run dev", count = 3, hidden = true })
local vifm = Terminal:new({ cmd = "vifm", count = 4, hidden = true })

vim.api.nvim_create_user_command('NpmStart', function() npm_start_runner:toggle() end, {})
vim.api.nvim_create_user_command('NpmRunDev', function() npm_dev_runner:toggle() end, {})
vim.api.nvim_create_user_command('Vifm', function() vifm:toggle() end, {})
vim.api.nvim_create_user_command('LazyGit', function() lazygit:toggle() end, {})
