syntax on
set title
set ambiwidth=double
set cindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set nrformats-=octal
set hidden
set history=500
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set wildmenu
set incsearch
set hlsearch
set mouse=a
set number
set ruler
set laststatus=2
set scrolloff=8

" Ctr-a, eで移動
inoremap <silent> <C-a> <Esc>^<Insert>
inoremap <silent> <C-e> <Esc>$<Insert><Right>

" tabの設定
set expandtab
set tabstop=2
set shiftwidth=2


 " Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

 if &compatible
   set nocompatible               " Be iMproved
 endif

 " Required:
 set runtimepath^=~/.vim/bundle/neobundle.vim/

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 NeoBundle 'scrooloose/nerdtree'
 NeoBundle 'scrooloose/syntastic.git'
 NeoBundle 'itchyny/vim-cursorword'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!

 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck
