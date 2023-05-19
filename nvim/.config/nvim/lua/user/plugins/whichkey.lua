local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	print("Unable to load: whichkey")
	return
end

local setup = {
	plugins = {
		marks = true,       -- shows a list of your marks on ' and `
		registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false,      -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true,       -- default bindings on <c-w>
			nav = false,          -- misc bindings to work with windows
			z = true,             -- bindings for folds, spelling and others prefixed with z
			g = true,             -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		["<space>"] = "󱁐",
		["<cr>"] = "󱞦",
		["<tab>"] = "󰞔",
		["<esc>"] = "󱊷",
	},
	icons = {
		breadcrumb = "󰁕", -- symbol used in the command line area that shows your active key combo
		separator = "󰜴", -- symbol used between a key and it's label
		group = "󰄠 ",  -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>",   -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded",       -- none, single, double, shadow
		position = "bottom",      -- bottom, top
		margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
		padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 5, max = 25 },                                             -- min and max height of the columns
		width = { min = 20, max = 30 },                                             -- min and max width of the columns
		spacing = 2,                                                                -- spacing between columns
		align = "left",                                                             -- align columns left, center or right
	},
	ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true,                                                             -- show help message on the command line when the popup is visible
	triggers = "auto",                                                            -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "i", "i" },
	},
	triggers_nowait = {
		-- marks
		"`",
		"'",
		"g`",
		"g'",
	}
}

local mappings = {
	b = { "<cmd>Telescope buffers<CR>", "Buffers" },
	F = { "<cmd>Telescope find_files cwd=~/Workspace prompt_title=All\\ Projects\\ Files<CR>", "Files" },
	e = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },
	E = { "<cmd>Vifm<CR>", "Vifm" },
	h = { "<C-w>h", "Left split" },
	l = { "<C-w>l", "Right split" },
	j = { "<C-w>j", "Lower split" },
	k = { "<C-w>k", "Upper split" },
	p = { "<cmd>Telescope project display_type=full theme=dropdown<cr>", "Projects" },
	u = { "<cmd>Telescope undo<cr>", "Undo history" },
	q = {
		name = "QuickFix List",
		q = { "<cmd>Trouble quickfix<cr>", "Open Quickfix" },
		n = { "<cmd>Trouble document_diagnostics<cr>", "File Diagnostics" },
		N = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
		r = { "<cmd>Trouble lsp_references<cr>", "References" },
		g = { "<cmd>Gitsigns setqflist<cr>", "Git Hunks" },
		d = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
		i = { "<cmd>Trouble lsp_implementations<cr>", "Implementations" },
		t = { "<cmd>Trouble lsp_type_definitions<cr>", "Type Definitions" },
		T = { "<cmd>Trouble todo<cr>", "Todos" },
	},
	g = {
		name = "Git Stuff",
		C = { "<cmd>Telescope git_commits prompt_title=Git\\ History<cr>", "Commits" },
		c = { "<cmd>Telescope git_bcommits prompt_title=File\\ History<cr>", "File Commits" },
		s = { "<cmd>Telescope git_status<cr>", "Git status" },
		b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame line" },
		B = { "<cmd>Telescope git_branches<cr>", "Branches" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview hunk" },
		P = { "<cmd>lua require 'gitsigns'.preview_hunk_inline()<cr>", "Preview hunk inline" },
		f = { "<cmd>Telescope git_files<CR>", "Git Files" },
		d = { "<cmd>lua require 'gitsigns'.diffthis()<cr>", "File diff" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset hunk" },
		S = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage hunk" },
		U = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo stage hunk" },
		g = { "<cmd>LazyGit<cr>", "LazyGit" },
		G = { "<cmd>Gitsigns<cr>", "GitSigns menu" }
	},
	s = {
		name = "Search",
		C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
	},
	o = {
		name = "Open",
		L = { "<cmd>Lazy<cr>", "Lazy" },
		l = { "<cmd>LspInfo<cr>", "LspInfo" },
		m = { "<cmd>Mason<cr>", "Mason" },
		c = { "<cmd>NvimConfig<cr>", "NvimConfig" },
	},
	t = {
		name = "Toggle",
		o = { "<cmd>ToggleBGOpacity<cr>", "Background Opacity" },
		q = { "<cmd>TroubleToggle<cr>", "QuickFix/Trouble" },
		c = { "<cmd>ColorizerToggle<cr>", "Colorizer" },
		s = { "<cmd>ScrollbarToggle<cr>", "Scrollbar" },
		t = { "<cmd>TSToggle highlight<cr>", "Treesitter" },
		b = { "<cmd>ToggleBlankline<cr>", "Blankline" },
		g = { "<cmd>Gitsigns toggle_signs<cr>", "Gitsigns" },
	},
}

local opts = {
	mode = "n",     -- NORMAL mode
	prefix = "<leader>",
	buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true,  -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true,  -- use `nowait` when creating keymaps
}

which_key.register(mappings, opts)
which_key.setup(setup)
