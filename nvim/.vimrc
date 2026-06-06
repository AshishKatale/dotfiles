" Options
set viminfofile=$HOME/.local/.vim/viminfo
set runtimepath+=$HOME/.local/.vim
set runtimepath-=$HOME/.vim

let mapleader = " "
let maplocalleader = "\\"
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
highlight PmenuSbar ctermbg=240
highlight PmenuThumb ctermbg=246
highlight TabLineSel ctermbg=234 ctermfg=white
highlight TabLineFill cterm=none ctermbg=242
highlight netrwMarkFile cterm=bold ctermbg=242

" AutoCommands
augroup myCmds
	autocmd!

	autocmd InsertEnter * :set norelativenumber
	autocmd InsertLeave * :set relativenumber

	autocmd BufEnter * silent !echo -ne "\e[1 q"
	autocmd VimLeave * silent !echo -ne "\e[3 q"

	autocmd InsertEnter * silent !echo -ne "\e[3 q"
	autocmd InsertLeave * silent !echo -ne "\e[1 q"

	autocmd BufEnter * :setlocal cursorline
	autocmd WinLeave,BufLeave * :setlocal nocursorline

	autocmd FileType help,qf nnoremap <buffer> q :quit<CR>
	autocmd TerminalOpen * if &buftype == 'terminal'
	    \ | setlocal nonumber
	    \ | setlocal norelativenumber
	    \ | setlocal bufhidden=hide
	    \ | endif
augroup END

" save on W
command! W write

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

nnoremap <leader>\| :vnew<CR>
nnoremap <leader>_ :new<CR>
nnoremap <localleader>\| :vertical terminal<CR>
nnoremap <localleader>_ :terminal<CR>
nnoremap <localleader>\ :tab terminal<CR>

let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.4 } }
nnoremap <C-b> :FZF<CR>

