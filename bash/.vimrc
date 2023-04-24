" Options
set rnu
set nu
colorscheme murphy

set cursorline "yes"
set hlsearch
set clipboard=unnamedplus

highlight Normal guibg=NONE ctermbg=NONE

" AutoCommands
augroup myCmds
au!
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber 

autocmd VimEnter * silent !echo -ne "\e[1 q"
autocmd VimLeave * silent !echo -ne "\e[3 q"

autocmd InsertEnter * silent !echo -ne "\e[3 q"
autocmd InsertLeave * silent !echo -ne "\e[1 q"
augroup END 

" Keymaps
inoremap jk <esc>
vnoremap ii <esc>
nnoremap <C-l> :noh<CR>

vnoremap p "_dP
vnoremap > >gv
vnoremap < <gv
nnoremap J mzJ`z

nnoremap j :m .+1<cr>==
nnoremap k :m .-2<cr>==
inoremap j <esc>:m .+1<cr>==gi
inoremap k <esc>:m .-2<cr>==gi
vnoremap j :m '>+1<CR>gv-gv
vnoremap k :m '<-2<CR>gv-gv

nnoremap <C-Up> :resize +2<CR> 
nnoremap <C-Down> :resize -2<CR> 
nnoremap <C-Left> :vertical resize -2<CR> 
nnoremap <C-Right> :vertical resize +2<CR> 

