----------- Custom User Commands ------------
vim.api.nvim_create_user_command('ToggleBlankline', " execute 'IndentBlanklineToggle' | set list!", {})
vim.api.nvim_create_user_command('NvimConfig', 'Telescope find_files hidden=true cwd=$DOTFILES', {})
vim.api.nvim_create_user_command('Format', "execute 'lua vim.lsp.buf.format()'", {})

vim.api.nvim_create_user_command('ToggleBGOpacity', function()
	local hl = vim.api.nvim_get_hl_by_name("Normal", {})
	if hl.background == nil then
		vim.cmd("hi Normal guifg=#d4d4d4 guibg=#181818")
		vim.cmd("hi NormalFloat guifg=#bbbbbb guibg=#272727")
		vim.cmd("hi NvimTreeNormal guifg=#d4d4d4 guibg=#1e1e1e")
		vim.cmd("hi FocusedWindow guibg=#181818")
		vim.cmd("hi LineNr guifg=#5a5a5a guibg=#181818")
		vim.cmd("hi SignColumn guibg=#1e1e1e")
		vim.cmd("hi MasonNormal guibg=#0b001d")
		vim.cmd("hi VertSplit guifg=#444444 guibg=#1e1e1e")
	else
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "FocusedWindow", { bg = "none" })
		vim.cmd("hi LineNr guibg=NONE")
		vim.cmd("hi SignColumn guibg=NONE")
		vim.cmd("hi MasonNormal guibg=#0b001d")
		vim.cmd("hi VertSplit guifg=#666666 guibg=NONE")
		vim.cmd("hi NoiceMini guifg=#ffff00")
		vim.cmd("hi NoiceLspProgressSpinner guifg=#00ffaa")
		vim.cmd("hi NoiceLspProgressTitle guifg=#ff9e64")
		vim.cmd("hi NoiceLspProgressClient guifg=#ff9e64")
	end
end, {})

------------ Custom AutoCommands ------------

local myAugroup = vim.api.nvim_create_augroup("myAugroup", { clear = true })

-- set transparent background on opening neovim
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	command = "ToggleBGOpacity",
	group = myAugroup
})

-- highlight text on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
	group = myAugroup
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
		if vim.bo.filetype == "TelescopePrompt" or vim.bo.filetype == "NvimTree" then return end
		vim.opt.relativenumber = true
	end,
	group = myAugroup
})

-- open quickfix list item with 'l'
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "qf",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "l", "<cr>", { noremap = true })
	end,
	group = myAugroup
})
