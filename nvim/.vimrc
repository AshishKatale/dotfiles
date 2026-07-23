" Options
set runtimepath-=$HOME/.vim
set runtimepath+=$HOME/.local/state/vim
runtime ftplugin/man.vim

let s:viminfo_dir = expand('$HOME/.local/state/vim')
if !isdirectory(s:viminfo_dir)
  call mkdir(s:viminfo_dir, 'p')
endif
set viminfofile=$HOME/.local/state/vim/viminfo

let s:undo_dir = expand('$HOME/.local/state/vim/undo')
if !isdirectory(s:undo_dir)
  call mkdir(s:undo_dir, 'p')
endif
execute 'set undodir=' . s:undo_dir
set undofile

let mapleader = " "
let maplocalleader = "\\"
let g:netrw_liststyle = 3
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" let g:netrw_browse_split = 4

let &t_SI = "\e[3 q"    " blink bar
let &t_EI = "\e[1 q"    " blink block

colorscheme desert
syntax on
set number
set relativenumber
set cursorline
set hlsearch
set splitbelow
set splitright
set ignorecase
set smartcase
set fixendofline
set expandtab
set tabstop=4
set shiftwidth=4
set signcolumn=yes
set foldcolumn=1
set colorcolumn=81
set laststatus=2
set scrolloff=8
set showtabline=1
set shortmess-=S
set nrformats=blank,bin,hex
set wildmenu
set wildoptions+=pum
set pumheight=15
set pumborder=round
set path+=**
set listchars=tab:>\ ,lead:·,trail:•,eol:\\
set fillchars=eob:\ ,vert:\│,fold:\ ,foldsep:\ 
set statusline=[%n]\ %t\ %m\ %r\ %h\ %=\ %y\ [%l,%v]\ [%P]\ [%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}]
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep\ --hidden\ --glob\ \"!**/.git/**\"

highlight Normal                         ctermbg=NONE
" highlight Normal                         ctermbg=233
highlight NonText          ctermfg=240   ctermbg=NONE
highlight SpecialKey       ctermfg=240   ctermbg=NONE
highlight Search           ctermfg=NONE  ctermbg=52    cterm=bold
highlight CurSearch        ctermfg=NONE  ctermbg=52    cterm=bold
highlight MatchParen       ctermfg=16    ctermbg=253
highlight VertSplit        ctermfg=243   ctermbg=NONE  cterm=NONE
highlight VertSplitNC      ctermfg=243   ctermbg=NONE  cterm=NONE
highlight TabLine          ctermfg=253   ctermbg=235   cterm=bold
highlight TabLineSel       ctermfg=16                  cterm=bold
highlight TabLineFill                    ctermbg=235
highlight StatusLine       ctermfg=253   ctermbg=235   cterm=bold
highlight StatusLineNC     ctermfg=246   ctermbg=235   cterm=NONE
highlight StatusLineTerm   ctermfg=253   ctermbg=235   cterm=bold
highlight StatusLineTermNC ctermfg=246   ctermbg=235   cterm=NONE
highlight QuickFixLine     ctermfg=253   ctermbg=238   cterm=bold
highlight CursorLine                     ctermbg=238   cterm=NONE
highlight CursorLineSign                 ctermbg=NONE
highlight LineNr           ctermfg=243                 cterm=NONE
highlight CursorLineNr     ctermfg=253                 cterm=NONE
highlight ColorColumn                    ctermbg=238   cterm=NONE
highlight Visual           ctermfg=253   ctermbg=24    cterm=NONE
highlight Pmenu            ctermfg=253   ctermbg=NONE
highlight PmenuSel         ctermfg=253   ctermbg=24
highlight PmenuSbar                      ctermbg=238
highlight PmenuThumb                     ctermbg=243
highlight PmenuBorder      ctermfg=243   ctermbg=NONE
highlight PmenuMatch       ctermfg=39    ctermbg=NONE  cterm=bold
highlight PmenuMatchSel    ctermfg=231   ctermbg=NONE  cterm=bold
highlight DiffAdd          ctermfg=253   ctermbg=22    cterm=NONE
highlight DiffText         ctermfg=253   ctermbg=18    cterm=bold
highlight DiffChange       ctermfg=253   ctermbg=130   cterm=NONE
highlight DiffDelete       ctermfg=52    ctermbg=52    cterm=NONE
highlight Folded           ctermfg=177   ctermbg=NONE  cterm=bold
highlight FoldColumn       ctermfg=177   ctermbg=NONE  cterm=bold
highlight CursorLineFold   ctermfg=177   ctermbg=NONE  cterm=bold
highlight Comment          ctermfg=71

" AutoCommands
augroup myCmds
    autocmd!

    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber

    autocmd BufEnter * silent !echo -ne "\e[1 q"
    autocmd VimLeave * silent !echo -ne "\e[3 q"

    autocmd InsertEnter * silent !echo -ne "\e[3 q"
    autocmd InsertLeave * silent !echo -ne "\e[1 q"

    autocmd FileType netrw nnoremap <silent> <buffer> Q :bd<CR>
    autocmd FileType help,qf,man nnoremap <silent> <buffer> q :quit<CR>

    autocmd BufEnter * if &buftype != 'terminal' | setlocal cursorline | endif
    autocmd WinLeave,BufLeave * :setlocal nocursorline

    autocmd TerminalOpen * if &buftype == 'terminal'
        \ | setlocal nonumber
        \ | setlocal norelativenumber
        \ | setlocal nocursorline
        \ | setlocal bufhidden=hide
        \ | setlocal foldcolumn=0
        \ | setlocal signcolumn=
        \ | setlocal colorcolumn=
        \ | endif
augroup END

function! FuzzyFindFunc(cmdarg, cmdcomplete)
    if executable('fzf')
        return systemlist("fd --type=f --type=l --hidden --exclude='.git' | fzf --scheme='path' --filter='" .. a:cmdarg .. "'")
    elseif strlen(a:cmdarg) > 0
        return matchfuzzy(systemlist("fd --type=f --type=l --hidden --exclude='.git'"), a:cmdarg)
    else
        return systemlist("fd --type=f --type=l --hidden --exclude='.git'")
    endif
endfunction

if executable('fd')
    set findfunc=FuzzyFindFunc
endif

let g:opacity = v:true
function! ToggleOpacity()
    if g:opacity
        highlight Normal ctermbg=233
    else
        highlight Normal ctermbg=NONE
    endif
    let g:opacity = !g:opacity
endfunction

let g:colcol = v:true
function! ToggleCC()
    if g:colcol
        set colorcolumn=
    else
        set colorcolumn=81
    endif
    let g:colcol = !g:colcol
endfunction

" :commands
command! W write
command! OpacityToggle call ToggleOpacity()
command! ColorColumnToggle call ToggleCC()

" Keymaps
inoremap jk <esc>
vnoremap ii <esc>
tnoremap ii <C-\><C-n>
nnoremap <C-l> :noh<CR>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

vnoremap p "_dP
vnoremap > >gv
vnoremap < <gv
nnoremap J mzJ`z

nnoremap j :m .+1<cr>==
inoremap j <esc>:m .+1<cr>==gi
vnoremap j :m '>+1<CR>gv-gv
nnoremap k :m .-2<cr>==
inoremap k <esc>:m .-2<cr>==gi
vnoremap k :m '<-2<CR>gv-gv

nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

nmap Y y$
nmap <leader>Y "+Y

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P
vnoremap p "_dP

nnoremap H :bp<CR>
nnoremap L :bn<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

nnoremap <leader>qq :copen<CR>
nnoremap <leader>qp :cprev<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qg :cfirst<CR>
nnoremap <leader>qG :clast<CR>

nnoremap <leader>tn :set number! relativenumber!<CR>
nnoremap <leader>tN :set nonumber norelativenumber<CR>
nnoremap <leader>tc :ColorColumnToggle<CR>
nnoremap <leader>to :OpacityToggle<CR>
nnoremap <leader>tw :set wrap!<CR>
nnoremap <leader>tl :set list!<CR>

nnoremap <leader>\| :vnew<CR>
nnoremap <leader>_ :new<CR>
nnoremap <localleader>\| :vertical terminal<CR>
nnoremap <localleader>_ :terminal<CR>
nnoremap <localleader>\ :tab terminal<CR>

let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.4 } }
nnoremap <C-b> :FZF<CR>

