scriptencoding 'utf-8'

if &compatible
	set nocompatible
endif

if len($H)
	let g:home = expand('$H')
	set runtimepath =~/.vim
	set runtimepath+=$H/.vim
else
	let g:home = expand('~')
endif

let g:vim_home = g:home . '/.vim'
let g:rc_dir   = g:vim_home . '/rc'
execute 'set runtimepath+=' . g:vim_home . '/after'

function s:load_rc(file)
	execute 'source ' . g:rc_dir . '/' . a:file . '.vim'
endfunction

call s:load_rc('setting') " オプション設定
call s:load_rc('keymap') " オプション設定

" NeoBundle {{{1
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Let NeoBundle manage NeoBundle
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

call s:load_rc('neobundle/unite') " 
call s:load_rc('neobundle/neocomplcache') " 
call s:load_rc('neobundle/fugitive') " 
call s:load_rc('neobundle/lightline') " 

NeoBundle 'scrooloose/nerdtree'

call neobundle#end()

filetype plugin indent on     " Required!
filetype indent on

NeoBundleCheck " Installation check.

