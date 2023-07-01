local plugins = {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("user.settings.theme")
		end
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		cmd = { "NvimTreeToggle" },
		config = function()
			require("user.plugins.nvimtree")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"arkav/lualine-lsp-progress"
		},
		config = function()
			require("user.plugins.lualine")
		end,
	},
	{
		"folke/which-key.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("user.plugins.whichkey")
		end,
	},
	{
		"tpope/vim-surround",
		lazy = true,
		event = { "BufEnter *.*" }
	},
	{
		"petertriho/nvim-scrollbar",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("user.plugins.utils.scrollbar")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("user.plugins.utils.colorizer")
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("user.plugins.utils.dressing")
		end
	},
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = { "LazyGit", "Vifm", "NpmStart", "NpmRunDev", "HttpServer" },
		keys = { "<F15>" },
		config = function()
			require("user.plugins.toggleterm")
		end,
	},
	{
		"folke/todo-comments.nvim",
		lazy = true,
		event = "BufEnter *.*",
		config = function()
			require("user.plugins.utils.todo")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = "BufEnter *.*",
		config = function()
			require("user.plugins.utils.blankline")
		end,
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "InsertEnter *.*",
		config = function()
			require("user.plugins.utils.autopairs")
		end,
	},
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = "Trouble",
		config = function()
			require("user.plugins.utils.trouble")
		end,
	},
	{ "debugloop/telescope-undo.nvim", lazy = true },
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		keys = { "<C-f>", "<F13>", "<C-p>" },
		cmd = { "Telescope" },
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("user.plugins.telescope")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		event = "BufEnter *.*",
	},
	{
		"numToStr/Comment.nvim",
	 	lazy = true,
	 	event = "BufEnter *.*",
 		config = function()
	 		require("user.plugins.utils.comments")
	 	end,
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufEnter *.*",
		config = function()
			require("user.plugins.utils.gitsigns")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = "BufEnter *.*",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("user.settings.treesitter")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter *.*",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets"
		},
		config = function()
			require("user.plugins.lsp.nvimcmp")
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = true,
		event = { "VeryLazy" },
		build = ":MasonUpdate",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("user.plugins.lsp")
		end
	},
}

return plugins

