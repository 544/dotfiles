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

" 全般 {{{1
set nocompatible "vi互換モードをオフ
set shellslash   "パス区切りをスラッシュにする
set lazyredraw   "スクリプト実行中の描画を抑制
set splitright   "vsplitで新規ウィンドウは右側にする
" }}}


"操作関係 {{{1
set scrolloff=10    "スクロール時に表示を5行確保

" 行折り返し \w
nnoremap <Leader>w  :set wrap!<CR>

"カーソルで4行ずつ移動
nnoremap <Up> 4k
nnoremap <Down> 4j

"表示行単位で移動
noremap j gj
noremap k gk
noremap gj j
noremap gk k

"挿入モードのカーソル移動
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <Left>
inoremap <M-l> <Right>

"最後に変更されたテキストを選択
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>

"挿入モードで範囲選択（セレクトモード）
set selectmode=key
set keymodel=startsel,stopsel
snoremap <C-S-Up> <S-Up><S-Up><S-Up><S-Up><S-Up>
snoremap <C-S-Down> <S-Down><S-Down><S-Down><S-Down><S-Down>

"フレームサイズをテンキーの+-で変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-

"ウィンドウ移動
nnoremap <S-Up> <C-W>k
nnoremap <S-Down> <C-W>j
nnoremap <S-Left> <C-W>h
nnoremap <S-Right> <C-W>l

"バッファ切り替え
nnoremap <S-PageDown> :<C-u>bn<CR>
nnoremap <S-PageUp>   :<C-u>bp<CR>

"タブ表示
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

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
NeoBundle 'https://github.com/Shougo/neocomplcache.vim'
NeoBundle 'https://github.com/Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'tpope/vim-fugitive' # cant install bundle...
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'https://github.com/Shougo/unite.vim'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'https://github.com/h1mesuke/unite-outline'
NeoBundle 'scrooloose/syntastic.git', {
            \ 'build': {
            \   'mac': ['pip install pyflake', 'npm -g install coffeelint'],
            \   'unix': ['pip install pyflake', 'npm -g install coffeelint']
            \ }}
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'spolu/dwm.vim'

" Unite 設定
noremap zp :Unite buffer_tab file_mru<CR>
noremap zn :UniteWithBufferDir -buffer-name=files file file/new<CR>


"for vimshell {{{2
" vimsehll
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USER."% "
" vimshell map
nmap vs :VimShell<CR>
nmap vp :VimShellPop<CR>

" for git {{{2
NeoBundle 'https://github.com/tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'

NeoBundle 'itchyny/lightline.vim' " ステータスライン

call neobundle#end()

filetype plugin indent on     " Required!
filetype indent on

" Installation check.
NeoBundleCheck

" ------ setting for neocomplcache {{{2

" 起動時に有効
let g:neocomplcache_enable_at_startup = 1
" snippet ファイルの保存先
let g:neocomplcache_snippets_dir='~/.vim/snippets'
" dictionary
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'objc' : $HOME . '/.vim/dict/objc.dict'
\ }
" 日本語をキャッシュしない
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" 補完候補の数
let g:neocomplcache_max_list = 5
" 1番目の候補を自動選択
let g:neocomplcache_enable_auto_select = 1
" 辞書読み込み
noremap  <Space>d. :<C-u>NeoComplCacheCachingDictionary<Enter>
" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" C-nでneocomplcache補完
inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
" 補完候補が表示されている場合は確定。そうでない場合は改行
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"
" 補完をキャンセル
inoremap <expr><C-e>  neocomplcache#close_popup()


" setting for neosnippet

" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"==== for unite {{{2
"" Unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
noremap <C-U><C-Y>    :     Unite -buffer-name=register register<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
noremap  <C-U><C-B>   :Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
noremap  <C-U><C-F>   :     UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
noremap <C-U><C-R>    :Unite file_mru<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer bookmark<CR>
noremap <C-U><C-U>    :     Unite file_mru buffer bookmark<CR>
noremap <C-U><C-O>    :Unite -vertical -winwidth=30 outline -no-quit<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" for vim-fugitive {{{2
nnoremap <Space>gd :<C-u>Gvdiff<Enter>
nnoremap <Space>gs :<C-u>Gstatus<Enter>
nnoremap <Space>gl :<C-u>Glog<Enter>
nnoremap <Space>ga :<C-u>Gwrite<Enter>
nnoremap <Space>gc :<C-u>Gcommit -v<Enter>
nnoremap <Space>gC :<C-u>Git commit --amend<Enter>
nnoremap <Space>gb :<C-u>Gblame<Enter>
nnoremap <Space>gv :<C-u>Gitv<Enter>

" for lightline {{{2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
      \ },
      \ 'component_function' : {
      \	  'filename': 'MyFileName', 
      \ }, 
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }


function! MyFileName()
	return expand('%:p')
endfunction

" 言語設定/その他 {{{1

" for coffeeScript
" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

" for scala
autocmd FileType scala :compiler scalac
autocmd QuickFixCmdPost make if len(getqflist()) != 0 | copen | endif

"memo
function! Memo()
	if has('win32')
		let $memofile = C:/memo.lst
	else
		let $memofile = '~/.vim/memo.lst'
	endif
	:tabnew $memofile
endf
command! Memo :call Memo()

" モードラインを有効にする。 {{{1
"set modeline
"set modelines=3
" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0

