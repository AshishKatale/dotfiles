return {
  'lervag/vimtex',
  lazy = true,
  event = 'BufNew *.tex',
  -- tag = "v2.15",
  init = function()
    -- needs latexmk, zathura and texlive to work
    vim.g.vimtex_view_method = 'mupdf'
  end
}
