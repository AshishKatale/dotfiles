local opt = vim.opt
-- opt.lines = 768                             -- set height to fullscreen
-- opt.columns = 1366                          -- set width to fullscreen
-- opt.fileencoding = "utf-8"                  -- the encoding written to a file
-- opt.clipboard = "unnamedplus"               -- use system clipboard
opt.backup = false                          -- creates a backup file
opt.cmdheight = 1                           -- neovim command line height
opt.completeopt = { 'menuone', 'noselect' } -- mostly just for cmp
opt.conceallevel = 0                        -- make `` visible in markdown files
opt.hlsearch = true                         -- highlight all matches on search
opt.ignorecase = true                       -- ignore case in search patterns
opt.mouse = ''                              -- disable mouse inside neovim
opt.pumheight = 15                          -- popup menu height
opt.showmode = false                        -- hide -- INSERT -- in cmd line
opt.showtabline = 2                         -- always show tabs
opt.smartcase = true                        -- smart case
opt.smartindent = true                      -- make indenting smarter again
opt.splitbelow = true                       -- force horizontal splits below
opt.splitright = true                       -- force vertical splits to right
opt.swapfile = false                        -- don't create a swapfile
opt.termguicolors = true                    -- set term gui colors
opt.timeoutlen = 1000                       -- time to wait for mapped sequence
opt.undofile = true                         -- enable persistent undo
opt.updatetime = 500                        -- faster completion default 4000ms
opt.timeout = true
opt.timeoutlen = 500
opt.writebackup = false   -- disable editing file being edited by other program

opt.expandtab = true      -- convert tabs to spaces
opt.shiftwidth = 2        -- the number of spaces inserted for each indentation
opt.tabstop = 2           -- insert 2 spaces for a tab
opt.cursorline = true     -- highlight the current line
opt.number = true         -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.numberwidth = 2       -- set number column width to 2 {default 4}
opt.signcolumn = 'yes:1'  -- always show the sign column
opt.wrap = true           -- display lines as one long line
opt.fixeol = false        -- disable insert newline at EOF
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.colorcolumn = '81'

opt.list = true
opt.fillchars:append('diff:·') -- render diff empty lines as ······
opt.fillchars:append('eob: ') -- hide ~ on empty buffer
opt.listchars:append('trail:') -- render trailing spaces as ·
opt.listchars:append('tab:  ') -- don't render tabs

-- opt.whichwrap:append('h,l') -- wrap to next line
-- opt.shortmess:append("c")
-- opt.iskeyword:append('-') -- treat kebab cased text as a single word

opt.guicursor = 'n-v-c-sm:block,' ..
    'ci-ve:ver25,' ..
    'i-r-cr-o:hor20,' .. -- cursor style '_' in insert mode
    'i:blinkwait1000-blinkoff400-blinkon300';
