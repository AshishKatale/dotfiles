" Options
set viminfofile=~/.local/.vim/viminfo
set runtimepath+=~/.local/.vim
set runtimepath-=~/.vim

let mapleader = " "
let maplocalleader = " "

syntax on

set nu
set rnu
set hlsearch
set colorcolumn=80
set laststatus=2
" set showtabline=2
set path+=**
set wildmenu
set fillchars=vert:\ ,fold:-,eob:\ ,lastline:@
set statusline=[%n]\ %t\ %m\ %r\ %h\ %=\ %y\ [%l,%v]\ [%P]\ [%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}]

let &t_SI = "\e[3 q"    " blink bar
let &t_EI = "\e[1 q"    " blink block

highlight Normal ctermbg=NONE
highlight Search ctermfg=0 ctermbg=42
highlight VertSplit cterm=NONE ctermbg=242
highlight StatusLine cterm=NONE ctermbg=240
highlight CursorLine cterm=NONE ctermbg=236
highlight StatusLineNC cterm=NONE ctermbg=237
highlight LineNr cterm=NONE ctermfg=244
highlight CursorLineNr cterm=NONE ctermfg=252
highlight ColorColumn cterm=NONE ctermbg=236
highlight Visual cterm=NONE ctermbg=73 ctermfg=0
highlight DiffAdd cterm=bold ctermfg=15 ctermbg=71
highlight DiffText   cterm=bold ctermfg=15 ctermbg=24
highlight DiffChange cterm=bold ctermfg=15 ctermbg=17
highlight DiffDelete cterm=bold ctermfg=124 ctermbg=124
highlight QuickFixLine ctermfg=15 ctermbg=8
highlight Pmenu ctermfg=white ctermbg=8
highlight PmenuSel ctermfg=0 ctermbg=7
highlight TabLineSel ctermbg=234 ctermfg=white
highlight TabLineFill cterm=none ctermbg=242

" AutoCommands
augroup myCmds
au!

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

autocmd VimEnter * silent !echo -ne "\e[1 q"
autocmd VimLeave * silent !echo -ne "\e[3 q"

autocmd InsertEnter * silent !echo -ne "\e[3 q"
autocmd InsertLeave * silent !echo -ne "\e[1 q"

autocmd BufEnter * :setlocal cursorline
autocmd WinLeave,BufLeave * :setlocal nocursorline

augroup END

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
nmap <leader>Y "+Y
nmap <leader>p "+p
nmap <leader>P "+P
vnoremap p "_dP

nmap H :bp<CR>
nmap L :bn<CR>
nmap <leader>e :Explore<cr>
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l

