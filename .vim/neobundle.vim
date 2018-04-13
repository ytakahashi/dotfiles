
" Required:
set runtimepath^=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Konfekt/FastFold'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'yonchu/accelerated-smooth-scroll'

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'solarized'
      \ }
