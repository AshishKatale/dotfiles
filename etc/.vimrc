" Options
set viminfofile=~/.local/.vim/viminfo
set runtimepath+=~/.local/.vim
set runtimepath-=~/.vim

let mapleader = " "
let maplocalleader = " "
let g:netrw_liststyle = 3
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" let g:netrw_browse_split = 4

let &t_SI = "\e[3 q"    " blink bar
let &t_EI = "\e[1 q"    " blink block

syntax on

set nu
set rnu
set hlsearch
set pumheight=15
set colorcolumn=81
set laststatus=2
set scrolloff=8
" set showtabline=2
set splitbelow
set splitright
set path+=**
set wildmenu
set wildoptions+=pum
set fillchars=eob:\ ,vert:\┃,fold:-
set statusline=[%n]\ %t\ %m\ %r\ %h\ %=\ %y\ [%l,%v]\ [%P]\ [%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}]

" highlight Normal ctermbg=234
highlight Normal ctermbg=NONE
highlight Search cterm=bold ctermfg=15 ctermbg=52
highlight CurSearch cterm=bold ctermfg=15 ctermbg=172
highlight MatchParen ctermfg=0 ctermbg=7
highlight VertSplit cterm=NONE ctermfg=242 ctermbg=NONE
highlight StatusLine cterm=NONE ctermbg=240
highlight CursorLine cterm=NONE ctermbg=236
highlight StatusLineNC cterm=NONE ctermbg=237
highlight LineNr cterm=NONE ctermfg=244
highlight CursorLineNr cterm=NONE ctermfg=252
highlight ColorColumn cterm=NONE ctermbg=236
highlight visual cterm=NONE ctermbg=24 ctermfg=15
highlight DiffAdd cterm=bold ctermfg=15 ctermbg=71
highlight DiffText   cterm=bold ctermfg=15 ctermbg=24
highlight DiffChange cterm=bold ctermfg=15 ctermbg=17
highlight DiffDelete cterm=bold ctermfg=124 ctermbg=124
highlight QuickFixLine ctermfg=15 ctermbg=8
highlight Pmenu ctermfg=white ctermbg=8
highlight PmenuSel ctermfg=0 ctermbg=7
highlight PmenuThumb ctermbg=0 ctermbg=240
highlight TabLineSel ctermbg=234 ctermfg=white
highlight TabLineFill cterm=none ctermbg=242
highlight netrwMarkFile cterm=bold ctermbg=242

" AutoCommands
augroup myCmds
au!

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

autocmd BufEnter * silent !echo -ne "\e[1 q"
autocmd VimLeave * silent !echo -ne "\e[3 q"

autocmd InsertEnter * silent !echo -ne "\e[3 q"
autocmd InsertLeave * silent !echo -ne "\e[1 q"

autocmd BufEnter * :setlocal cursorline
autocmd WinLeave,BufLeave * :setlocal nocursorline

augroup END

" save on W
command! W  write

" Keymaps
inoremap jk <esc>
vnoremap ii <esc>
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
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>Y "+Y
nmap <leader>p "+p
vmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>P "+P
vnoremap p "_dP

nmap H :bp<CR>
nmap L :bn<CR>
nmap <leader>e :Explore<cr>
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l

