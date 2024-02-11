----------- Custom User Commands ------------
local myAugroup = vim.api.nvim_create_augroup("myAugroup", { clear = true })

vim.api.nvim_create_user_command(
  'NvimConfig',
  'Telescope find_files hidden=true cwd=$DOTFILES/nvim prompt_title=Nvim\\ Config',
  {}
)

vim.api.nvim_create_user_command(
  'Format',
  function()
    vim.lsp.buf.format({ timeout_ms = 30000 })
  end,
  {}
)

vim.api.nvim_create_user_command(
  'BlanklineToggle',
  "execute 'IBLToggle' | set list!",
  {}
)

vim.api.nvim_create_user_command('ColorColumnToggle', function()
  local colorcolumn = vim.api.nvim_get_option_value("colorcolumn", {
    scope = "local"
  })
  if colorcolumn == "80" then
    vim.api.nvim_set_option_value("colorcolumn", "", { scope = "local" })
  else
    vim.api.nvim_set_option_value("colorcolumn", "80", { scope = "local" })
  end
end, {})

vim.api.nvim_create_user_command('OpacityToggle', function()
  local hl = vim.api.nvim_get_hl_by_name("Normal", {})
  if hl.background == nil then
    vim.cmd("hi Normal guifg=#d4d4d4 guibg=#181818")
    vim.cmd("hi NormalFloat guifg=#bbbbbb guibg=#272727")
    vim.cmd("hi NvimTreeNormal guifg=#d4d4d4 guibg=#1e1e1e")
    vim.cmd("hi LineNr guifg=#5a5a5a guibg=#181818")
    vim.cmd("hi CursorLineNr guibg=#1e1e1e")
    vim.cmd("hi SignColumn guibg=#1e1e1e")
    vim.cmd("hi VertSplit guifg=#444444 guibg=#1e1e1e")
  else
    vim.cmd("hi Normal guibg=NONE")
    vim.cmd("hi NormalFloat guibg=NONE")
    vim.cmd("hi NvimTreeNormal guibg=NONE")
    vim.cmd("hi LineNr guibg=NONE")
    vim.cmd("hi CursorLineNr guibg=NONE")
    vim.cmd("hi SignColumn guibg=NONE")
    vim.cmd("hi VertSplit guifg=#666666 guibg=NONE")
  end
end, {})

vim.g.format_on_save_cmd = nil
vim.api.nvim_create_user_command(
  'FormatOnSaveToggle',
  function()
    if vim.g.format_on_save_cmd ~= nil then
      vim.api.nvim_del_autocmd(vim.g.format_on_save_cmd)
      vim.g.format_on_save_cmd = nil
    else
      vim.g.format_on_save_cmd = vim.api.nvim_create_autocmd('BufWritePost', {
        group = myAugroup,
        callback = function()
          vim.lsp.buf.format({ async = true })
        end,
      })
    end
  end,
  {}
)

vim.api.nvim_create_user_command('RemoveTrailingSpaces', "%s/\\s\\+$//e", {})

------------ Custom AutoCommands ------------

-- set transparent background on opening neovim
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  command = "OpacityToggle",
  group = myAugroup
})

-- highlight text on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
  group = myAugroup
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local opts = {
      noremap = true,
      silent = true,
      nowait = true
    };
    if vim.bo.filetype == "help" then
      vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", opts);
      vim.api.nvim_set_option_value("number", true, { buf = 0 });
      vim.api.nvim_set_option_value("relativenumber", true, { buf = 0 });
    elseif vim.bo.filetype == "qf" then
      vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", opts)
    end
  end
})

-- reset cursor style to underline before exiting
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function() vim.opt.guicursor = 'a:hor20' end,
  group = myAugroup
})

-- set absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function() vim.opt.relativenumber = false end,
  group = myAugroup
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    if vim.bo.filetype == "Trouble" or
        vim.bo.filetype == "help" or
        vim.bo.filetype == "startup" or
        vim.bo.filetype == "TelescopePrompt" or
        vim.bo.filetype == "DressingInput" or
        vim.bo.filetype == "NvimTree"
    then
      return
    end
    vim.opt.relativenumber = true
  end,
  group = myAugroup
})

-- open quickfix list item with 'l'
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "Trouble" },
  callback = function()
    local match = vim.fn.expand("<amatch>")
    if match == "qf" then
      vim.api.nvim_buf_set_keymap(0, "n", "l", "<cr>", { noremap = true })
    elseif match == "Trouble" then
      vim.cmd("set nu signcolumn=yes")
    end
  end,
  group = myAugroup
})
