return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
      input = {
        relative = "editor",
        win_options = {
          -- Window transparency (0-100)
          winblend = 0,
          -- Disable line wrapping
          wrap = false,
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },
      }
    })
  end
}
