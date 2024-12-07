return {
  'lervag/vimtex',
  lazy = true,
  ft = 'tex',
  -- event = 'BufNew *.tex',
  -- tag = "v2.15",
  init = function()
    -- needs latexmk, zathura and texlive to work
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_view_forward_search_on_start = false
  end
}
