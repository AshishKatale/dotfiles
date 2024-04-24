return {
  "folke/trouble.nvim",
  lazy = true,
  cmd = "Trouble",
  config = function()
    require("trouble").setup({
      position = "bottom",
      height = 10,
      width = 50,
      icons = true,
      mode = "workspace_diagnostics",
      fold_open = "",
      fold_closed = "",
      group = true,
      padding = false,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "<cr>", "l" },
        open_split = { "<c-x>" },
        open_vsplit = { "<c-v>" },
        open_tab = { "<c-t>" },
        jump_close = { "o" },
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = { "zM", "zm", "H" },
        open_folds = { "zR", "zr", "L" },
        toggle_fold = { "zA", "za", "h" },
        previous = "k",
        next = "j"
      },
      indent_lines = true,
      auto_open = false,
      auto_close = false,
      auto_preview = true,
      auto_fold = false,
      auto_jump = { "lsp_definitions" },
      use_diagnostic_signs = true
    })
  end,
}
