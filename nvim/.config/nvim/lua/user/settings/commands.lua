----------- Custom User Commands ------------
vim.api.nvim_create_user_command('ToggleBlankline', " execute 'IndentBlanklineToggle' | set list!", {})
vim.api.nvim_create_user_command('NvimConfig', 'Telescope find_files hidden=true cwd=$DOTFILES/nvim prompt_title=Nvim\\ Config', {})
vim.api.nvim_create_user_command('Format', "execute 'lua vim.lsp.buf.format({ timeout_ms = 30000 })'", {})

vim.api.nvim_create_user_command('ToggleBGOpacity', function()
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

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.filetype == "help" and vim.opt.relativenumber._value == false then
			vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", { noremap = true, silent = true, nowait = true })
			vim.cmd("set nu rnu signcolumn=no")
		elseif vim.bo.filetype == "qf" then
			vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", { noremap = true, silent = true, nowait = true })
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
		then return end
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

