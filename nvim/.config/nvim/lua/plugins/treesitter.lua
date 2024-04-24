local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-context" },
  lazy = true,
  event = "BufEnter *.*",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
}

M.opts = function()
  return {
    ensure_installed = {
      "vim", "vimdoc", "regex", "lua", "bash",
      "yaml", "xml", "json", "csv", "sql", "gitignore",
      "css", "scss", "html", "javascript",
      "typescript", "tsx", "jsdoc", "java",
      "c", "cpp", "rust", "go", "gomod", "gosum",
    },
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
      enable = true,         -- false will disable the whole extension
      disable = { "" },      -- list of language that will be disabled
      additional_vim_regex_highlighting = true,
    },
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable

      -- highlight non-bracket delimiters like html tags,
      -- boolean or table: lang -> boolean
      extended_mode = true,
      max_file_lines = 4000, -- Do not enable for files with more than n lines
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
    indent = { enable = true, disable = { "yaml" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "vv",
        node_incremental = "K",
        scope_incremental = "L",
        node_decremental = "J",
      },
    },
  }
end

M.config = function(_, opts)
  require("nvim-treesitter.configs").setup(opts)
  vim.cmd("hi TreesitterContextLineNumber guifg=#bbbbbb")
end

return M
