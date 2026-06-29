"lOptions
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

colorscheme desert
syntax on
set number
set relativenumber
set cursorline
set hlsearch
set fixendofline
set expandtab
set tabstop=4
set shiftwidth=4
set signcolumn=yes
set pumheight=15
set colorcolumn=81
set laststatus=2
set scrolloff=8
set showtabline=1
set splitbelow
set splitright
set path+=**
set wildmenu
set wildoptions+=pum
set listchars=tab:>\ ,space:·,trail:•,eol:$
set fillchars=eob:\ ,vert:\│,fold:-
set statusline=[%n]\ %t\ %m\ %r\ %h\ %=\ %y\ [%l,%v]\ [%P]\ [%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}]
set pumborder=custom:─;│;─;│;╭;╮;╯;╰
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep\ --hidden\ --glob\ \"!**/.git/**\"\ --glob\ \"!**/node_modules/**\"\ --glob\ \"!**/target/**\"

highlight Comment ctermfg=71
highlight Normal ctermbg=NONE
"highlight Normal ctermbg=234
highlight NonText ctermfg=245 ctermbg=NONE
highlight SpecialKey ctermfg=245 ctermbg=NONE
highlight Search cterm=bold ctermfg=255 ctermbg=130
highlight CurSearch cterm=bold ctermfg=255 ctermbg=130
highlight MatchParen ctermfg=0 ctermbg=248
highlight VertSplit cterm=NONE ctermfg=242 ctermbg=NONE
highlight TabLine cterm=NONE ctermfg=255 ctermbg=242 cterm=bold
highlight TabLineSel cterm=bold ctermfg=0
highlight TabLineFill ctermbg=240
highlight StatusLine cterm=NONE ctermfg=255 ctermbg=240 cterm=bold
highlight StatusLineNC cterm=NONE ctermfg=248 ctermbg=240
highlight StatusLineTerm cterm=NONE ctermfg=255 ctermbg=240 cterm=bold
highlight StatusLineTermNC cterm=NONE ctermfg=248 ctermbg=240
highlight CursorLine cterm=NONE ctermbg=238
highlight CursorLineSign ctermbg=NONE
highlight LineNr cterm=NONE ctermfg=244
highlight CursorLineNr cterm=NONE ctermfg=252
highlight ColorColumn cterm=NONE ctermbg=238
highlight visual cterm=NONE ctermbg=24 ctermfg=15
highlight QuickFixLine cterm=bold ctermfg=15 ctermbg=8
highlight Pmenu ctermbg=NONE
highlight PmenuSbar ctermbg=240
highlight PmenuBorder ctermfg=246 ctermbg=NONE
highlight PmenuMatch ctermfg=39 ctermbg=NONE cterm=bold
highlight PmenuMatchSel ctermfg=18 cterm=bold
highlight DiffAdd cterm=bold ctermfg=15 ctermbg=28
highlight DiffText   cterm=bold ctermfg=15 ctermbg=18
highlight DiffChange cterm=bold ctermfg=15 ctermbg=130
highlight DiffDelete cterm=bold ctermfg=124 ctermbg=124

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
    autocmd FileType help,qf nnoremap <silent> <buffer> q :quit<CR>

    autocmd BufEnter * if &buftype != 'terminal' | setlocal cursorline | endif
    autocmd WinLeave,BufLeave * :setlocal nocursorline

    autocmd TerminalOpen * if &buftype == 'terminal'
        \ | setlocal nonumber
        \ | setlocal norelativenumber
        \ | setlocal nocursorline
        \ | setlocal bufhidden=hide
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
        highlight Normal ctermbg=234
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

