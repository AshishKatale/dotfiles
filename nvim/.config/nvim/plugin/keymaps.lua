-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Remap space as leader key
-- already set in init.lua before loading lazy
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = '\\'

local map = vim.keymap.set

-- Disable arrow keys
map({ 'n', 'v' }, ' ', '<Nop>', { silent = true })
map({ 'i', 'n', 'v' }, '<Up>', '<Nop>', { silent = true })
map({ 'i', 'n', 'v' }, '<Down>', '<Nop>', { silent = true })
map({ 'i', 'n', 'v' }, '<Left>', '<Nop>', { silent = true })
map({ 'i', 'n', 'v' }, '<Right>', '<Nop>', { silent = true })

map({ 'n' }, 'J', 'mzJ`z', { silent = true })

-- Resize with arrow
map({ 'n' }, '<C-Up>', ':resize +2<CR>', { silent = true })
map({ 'n' }, '<C-Down>', ':resize -2<CR>', { silent = true })
map({ 'n' }, '<C-Left>', '<cmd>vertical resize -2<CR>', { silent = true })
map({ 'n' }, '<C-Right>', '<cmd>vertical resize +2<CR>', { silent = true })

-- Navigate buffers
map({ 'n' }, '<S-l>', '<cmd>bn<CR>', { silent = true })
map({ 'n' }, '<S-h>', '<cmd>bp<CR>', { silent = true })

-- Press jk fast to enter normal mode
map({ 'i' }, 'jk', '<ESC>', { silent = true })
map({ 'v' }, 'ii', '<ESC>', { silent = true })
map({ 't' }, 'ii', [[<C-\><C-n>]], { silent = true })

-- Stay in indent mode
map({ 'v' }, '<', '<gv', { silent = true })
map({ 'v' }, '>', '>gv', { silent = true })

-- Move text up and down
map({ 'n', 'v' }, '<A-j>', '<cmd>m .+1<CR>==', { silent = true })
map({ 'n', 'v' }, '<A-k>', '<cmd>m .-2<CR>==', { silent = true })
map({ 'i' }, '<A-j>', '<Esc>:m .+1<CR>==a', { silent = true })
map({ 'i' }, '<A-k>', '<Esc>:m .-2<CR>==a', { silent = true })

-- copy-paste
map({ 'v' }, 'p', '\"_dP', { silent = true })
map({ 'n' }, '<leader>Y', '"+y$', { silent = true })
map({ 'n', 'v' }, '<leader>y', '"+y', { silent = true })
map({ 'n', 'v' }, '<leader>p', '"+p', { silent = true })
map({ 'n', 'v' }, '<leader>P', '"+P', { silent = true })

-- Visual Block --
map({ 'x' }, '<A-j>', ":move '>+1<CR>gv-gv", { silent = true })
map({ 'x' }, '<A-k>', ":move '<-2<CR>gv-gv", { silent = true })

map({ 'n', 't' }, '<C-\\>', '<cmd>FloatTerm<CR>', { silent = true })
