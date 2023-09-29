" Options
set runtimepath=~/.local/share/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim91,/usr/share/vim/vimfiles/after,~/.local/share/.vim/after
set viminfofile=~/.local/share/.vim/viminfo

set rnu
set nu

set cursorline "yes"
set hlsearch
set clipboard=unnamedplus
let mapleader = " "
set colorcolumn=80

let maplocalleader = " "

let &t_SI = "\e[3 q"    " blink bar
let &t_EI = "\e[1 q"    " blink block

highlight Normal guibg=NONE ctermbg=NONE
highlight CursorLine term=NONE cterm=NONE ctermbg=238 guibg=#444444
highlight LineNr term=NONE cterm=NONE ctermfg=244 guibg=NONE
highlight CursorLineNr term=NONE cterm=NONE ctermfg=252 guibg=NONE
highlight ColorColumn term=NONE cterm=NONE ctermbg=238 guibg=#252525
highlight Visual cterm=NONE term=NONE ctermbg=73 ctermfg=0 guibg=#5FAFAF guifg=#000000

" AutoCommands
augroup myCmds
au!

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber 

autocmd VimLeave * silent !echo -ne "\e[3 q"

autocmd InsertEnter * silent !echo -ne "\e[3 q"
autocmd InsertLeave * silent !echo -ne "\e[1 q"

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

nmap H :bp<CR>
nmap L :bn<CR>
nmap <leader>e :Explore<cr>
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l

