syntax on

set nobackup
set fileencoding="utf-8"
set hidden
set nowrap
set splitbelow
set splitright
set tabstop=2
set noerrorbells
set undodir=~/.vim/undodir
set undofile
set incsearch
set tabstop=2
set relativenumber
set number
set nohlsearch
set clipboard=unnamedplus

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

inoremap jk <Esc>
inoremap kj <Esc>

vnoremap < <gv
vnoremap > >gv
vnoremap K :move '<-2<CR>gv-gv
vnoremap J :move '>+2<CR>gv-gv


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

colorscheme slate
highlight LineNr ctermfg=Gray

autocmd BufWritePre * %s/\s\+$//e
autocmd VimEnter * silent !echo -ne "\e[2 q"
autocmd VimEnter * redraw!
