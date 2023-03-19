-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable arrow keys
vim.keymap.set({ "n", "v" }, " ", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "<Up>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "<Down>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "<Left>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "<Right>", "<Nop>", { silent = true })

vim.keymap.set({ "n" }, "J", "mzJ`z", { silent = true })

-- Resize with arrow
vim.keymap.set({ "n" }, "<C-Up>", ":resize +2<CR>", { silent = true })
vim.keymap.set({ "n" }, "<C-Down>", ":resize -2<CR>", { silent = true })
vim.keymap.set({ "n" }, "<C-Left>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set({ "n" }, "<C-Right>", "<cmd>vertical resize +2<CR>", { silent = true })

-- Navigate buffers
vim.keymap.set({ "n" }, "<S-l>", "<cmd>bn<CR>", { silent = true })
vim.keymap.set({ "n" }, "<S-h>", "<cmd>bp<CR>", { silent = true })

-- Press jk fast to enter normal mode
vim.keymap.set({ "i" }, "jk", "<ESC>", { silent = true })
vim.keymap.set({ "v" }, "ii", "<ESC>", { silent = true })
vim.keymap.set({ "t" }, "ii", [[<C-\><C-n>]], { silent = true })

-- Stay in indent mode
vim.keymap.set({ "v" }, "<", "<gv", { silent = true })
vim.keymap.set({ "v" }, ">", ">gv", { silent = true })

-- Move text up and down
vim.keymap.set({ "n", "v" }, "<A-j>", "<cmd>m .+1<CR>==", { silent = true })
vim.keymap.set({ "n", "v" }, "<A-k>", "<cmd>m .-2<CR>==", { silent = true })
vim.keymap.set({ "i" }, "<A-j>", "<Esc>:m .+1<CR>==a", { silent = true })
vim.keymap.set({ "i" }, "<A-k>", "<Esc>:m .-2<CR>==a", { silent = true })
vim.keymap.set({ "v" }, "p", "\"_dP", { silent = true })

-- Visual Block --
vim.keymap.set({ "x" }, "<A-j>", ":move '>+1<CR>gv-gv", { silent = true })
vim.keymap.set({ "x" }, "<A-k>", ":move '<-2<CR>gv-gv", { silent = true })

-- Copy lines
vim.keymap.set({ "i" }, "<F13>", "<Esc>yypi", { silent = true })
vim.keymap.set({ "i" }, "<F14>", "<Esc>yyPi", { silent = true })
vim.keymap.set({ "n" }, "<F13>", "yyp", { silent = true })
vim.keymap.set({ "n" }, "<F14>", "yyP", { silent = true })

-- Close buffer without closing window
vim.keymap.set({ "n", "i" }, "<C-k>x", "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>", { silent = true })
vim.keymap.set({ "n", "i" }, "<C-k><C-x>", "<cmd>1,$bd!<CR>", { silent = true })

