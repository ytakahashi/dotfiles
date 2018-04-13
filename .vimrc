syntax on

set notitle
set ambiwidth=double
set cindent
" set list
" set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set nrformats-=octal
set hidden
set history=500
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set wildmenu
set incsearch
set hlsearch
" set mouse=a
set number
set ruler
set laststatus=2
set scrolloff=8
set fenc=utf-8

" show input command
set showcmd

" 行末+1
set virtualedit=onemore

" clipboard
set clipboard=unnamed,autoselect
let OSTYPE = system('uname')
if OSTYPE == "Linux\n"
  vmap <C-c> :w !xsel -ib<CR><CR>
endif

" tab setting
set expandtab
set tabstop=2
set shiftwidth=2


" key mapping
inoremap <silent> <C-a> <Esc>^<Insert>
inoremap <silent> <C-e> <Esc>$<Insert><Right>
inoremap <silent> jj <ESC>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
noremap <Space><CR> o<ESC>
noremap <C-j> i<C-j><ESC>
nnoremap j gj
nnoremap k gk
nnoremap <Space>h  ^
nnoremap <Space>l  $
nnoremap <C-h> <Left>x
nnoremap <C-l> x
nnoremap ; :
nnoremap <space>pa  :set paste<CR>
nnoremap <space>sn  :set number<CR>
nnoremap <space>nn  :set nonu<CR>
nnoremap <Space>nt  :NERDTree<CR>
nnoremap <Space>nh  :noh<CR>
nnoremap <Space>md  :PrevimOpen<CR>
nnoremap <Space>c  :tabnew<CR>
nnoremap <Space>w  :w<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT

autocmd InsertLeave * set nopaste


" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
 set nocompatible               " Be iMproved
endif

colorscheme kafka 
hi LineNr ctermbg=234 ctermfg=94 


if filereadable(expand('~/dotfiles/.vim/neobundle.vim'))
  source ~/dotfiles/.vim/neobundle.vim
endif

" Required:
filetype plugin indent on