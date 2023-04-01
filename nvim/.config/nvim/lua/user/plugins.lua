local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("unable to start packer")
  return
end
-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install plugins here
return packer.startup(function(use)
  -- My plugins here
	use "wbthomason/packer.nvim" -- Have packer manage itself

	use "nvim-lua/popup.nvim"        -- An implementation of the Popup API from vim in Neovim
	use "nvim-lua/plenary.nvim"      -- Useful lua functions used ny lots of plugins
	use "nvim-tree/nvim-web-devicons"

	use "Mofiqul/vscode.nvim"

	-- Packer
	use({
		"folke/noice.nvim",
		config = function() end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
			}
	})

	use "akinsho/toggleterm.nvim"
	use "folke/which-key.nvim"
	use "nvim-lualine/lualine.nvim"
  use "petertriho/nvim-scrollbar"
	use "folke/trouble.nvim"
	use "folke/todo-comments.nvim"

	use "beauwilliams/focus.nvim"
	use "windwp/nvim-autopairs"
	use "lukas-reineke/indent-blankline.nvim"
	use 'norcalli/nvim-colorizer.lua'
	use "lewis6991/gitsigns.nvim"
	use "numToStr/Comment.nvim"
	use "p00f/nvim-ts-rainbow"
	use "tpope/vim-surround"

	use "nvim-telescope/telescope.nvim"
	use "debugloop/telescope-undo.nvim"
	use {
		"nvim-telescope/telescope-fzf-native.nvim",
		run = 'make'
	}

	use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
	use 'nvim-treesitter/nvim-treesitter-context'

	use 'nvim-tree/nvim-tree.lua'

	use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
	}

	use "hrsh7th/nvim-cmp"         -- Required
	use "hrsh7th/cmp-nvim-lsp"     -- Required
	use "hrsh7th/cmp-buffer"       -- Optional
	use "hrsh7th/cmp-path"         -- Optional

	-- -- Snippets
	use "L3MON4D3/LuaSnip"             -- Required
	use "rafamadriz/friendly-snippets" -- Optional

	if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
