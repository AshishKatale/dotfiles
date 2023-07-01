-- :help options
-- vim.opt.lines=768																					-- set height to fullscreen
-- vim.opt.columns=1366																			-- set width to fullscreen
vim.opt.backup = false                          -- creates a backup file
-- vim.opt.clipboard = "unnamedplus"            -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = nil                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 15                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 500                        -- faster completion (4000ms default)
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.expandtab = true													 -- convert tabs to spaces
vim.opt.shiftwidth = 2        -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2           -- insert 2 spaces for a tab
vim.opt.cursorline = true     -- highlight the current line
vim.opt.number = true         -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 2       -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes:1"  -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true           -- display lines as one long line
vim.opt.fixeol = false        -- disable insert newline at EOF
-- vim.opt.guifont = "monospace:h17"													-- the font used in graphical neovim applications
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- vim.opt.colorcolumn = '80'

vim.opt.listchars:append("tab:→ ") -- render tab as → when list option is set
vim.opt.listchars:append("space:·") -- render space as · when list option is set
-- vim.opt.listchars:append("eol:↴")													-- render eol as ↴ when list option is set
vim.opt.iskeyword:append('-')       -- treat kebab cased text as a single word
vim.opt.whichwrap:append('h,l')     -- wrap to next line

vim.opt.guicursor = 'n-v-c-sm:block,' ..
		'ci-ve:ver25,' ..
		'i-r-cr-o:hor20,' ..
		'i:blinkwait1000-blinkoff400-blinkon300';        -- changed cursor style to '_' in insert mode

-- vim.opt.shortmess:append "c"
-- vim.cmd [[set formatoptions-='cro']]
