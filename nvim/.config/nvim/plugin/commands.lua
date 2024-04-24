----------- Custom User Commands ------------
local myAugroup = vim.api.nvim_create_augroup("myAugroup", { clear = true })

vim.api.nvim_create_user_command(
  'LazyGit',
  function()
    local is_git_repo = vim.system(
      { "git", "rev-parse", "--is-inside-work-tree" },
      { text = true }
    ):wait().code == 0
    if is_git_repo then
      vim.cmd("tabnew term://lazygit")
      vim.keymap.set({ "t" }, "ii", "<Nop>", { silent = true, buffer = 0 })
      vim.keymap.set(
        { "t" }, "<C-\\>", [[<C-\><C-n>0M]],
        { silent = true, buffer = 0 }
      )
    else
      vim.print("Error: lazygit must be run inside a git repository")
    end
  end,
  {}
)

vim.api.nvim_create_user_command(
  'Vifm',
  function() vim.cmd("tabnew term://vifm") end,
  {}
)

vim.api.nvim_create_user_command(
  'Format',
  function() vim.lsp.buf.format({ timeout_ms = 30000 }) end,
  {}
)

vim.api.nvim_create_user_command(
  'BlanklineToggle',
  "execute 'IBLToggle' | set list!",
  {}
)

vim.api.nvim_create_user_command(
  'DiagnosticsToggle',
  function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
  {}
)

vim.api.nvim_create_user_command(
  'InlayhintsToggle',
  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  {}
)

vim.api.nvim_create_user_command(
  'FloatTerm',
  function(cmd)
    if #cmd.fargs > 0 then
      require("lazy.util").float_term(cmd.fargs, {})
    else
      require("lazy.util").float_term(nil, {})
    end
  end,
  {
    nargs = '*',
    complete = function(cmd)
      local cmds = { "btop", "top", "git log", "lazygit" }
      return vim.tbl_filter(
        function(c) return string.find(c, cmd) end,
        cmds
      )
    end,
  }
)

vim.api.nvim_create_user_command('ColorColumnToggle', function()
  local colorcolumn = tonumber(vim.api.nvim_get_option_value("colorcolumn", {
    scope = "local"
  }))
  if colorcolumn and colorcolumn > 0 then
    vim.api.nvim_set_option_value("colorcolumn", "", { scope = "local" })
  else
    vim.api.nvim_set_option_value("colorcolumn", "81", { scope = "local" })
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

-- highlight text on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
  group = myAugroup
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local opts = { noremap = true, silent = true, nowait = true };
    if vim.bo.filetype == "help" then
      vim.api.nvim_set_option_value("number", true, { scope = "local" })
      vim.api.nvim_set_option_value("relativenumber", true, { scope = "local" })
      vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", opts)
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

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  callback = function()
    vim.cmd("setlocal nonu nornu")
    vim.cmd('startinsert')
    vim.cmd('setlocal signcolumn=no')
  end,
  group = myAugroup
})

vim.api.nvim_create_autocmd({ "TermClose" }, {
  callback = function()
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<CR>", true, true, true),
      "n",
      true
    )
  end,
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
        vim.bo.filetype == "lazy" or
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
