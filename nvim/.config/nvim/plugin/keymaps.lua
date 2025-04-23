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
map({ 'n', 't' }, '<c-up>', '<cmd>resize +2<cr>', { silent = true })
map({ 'n', 't' }, '<c-down>', '<cmd>resize -2<cr>', { silent = true })
map({ 'n', 't' }, '<c-left>', '<cmd>vertical resize -2<cr>', { silent = true })
map({ 'n', 't' }, '<C-Right>', '<cmd>vertical resize +2<cr>', { silent = true })

-- Navigate buffers
map({ 'n' }, '<S-l>', '<cmd>bn<cr>', { silent = true })
map({ 'n' }, '<S-h>', '<cmd>bp<cr>', { silent = true })

-- Press jk fast to enter normal mode
map({ 'i' }, 'jk', '<ESC>', { silent = true })
map({ 'v' }, 'ii', '<ESC>', { silent = true })
map({ 't' }, 'ii', [[<C-\><C-n>]], { silent = true })

-- Stay in indent mode
map({ 'v' }, '<', '<gv', { silent = true })
map({ 'v' }, '>', '>gv', { silent = true })

-- Move text up and down
-- map({ 'n', 'v' }, '<A-j>', '<cmd>m .+1<cr>==', { silent = true })
-- map({ 'n', 'v' }, '<A-k>', '<cmd>m .-2<cr>==', { silent = true })
-- map({ 'i' }, '<A-j>', '<Esc><cmd>m .+1<cr>==a', { silent = true })
-- map({ 'i' }, '<A-k>', '<Esc><cmd>m .-2<cr>==a', { silent = true })

-- copy-paste
map({ 'v' }, 'p', '\"_dP', { silent = true })
map({ 'n' }, '<leader>Y', '"+y$', { silent = true })
map({ 'n', 'v' }, '<leader>y', '"+y', { silent = true })
map({ 'n', 'v' }, '<leader>p', '"+p', { silent = true })
map({ 'n', 'v' }, '<leader>P', '"+P', { silent = true })

-- Visual Block --
map({ 'x' }, '<A-j>', "<cmd>move '>+1<cr>gv-gv", { silent = true })
map({ 'x' }, '<A-k>', "<cmd>move '<-2<cr>gv-gv", { silent = true })

map({ 'n', 't' }, '<C-\\>', '<cmd>FloatTerm<cr>', { silent = true })
map({ 'n', 'i' }, '<C-b>', '<cmd>FzfLua files<cr>', { silent = true })
