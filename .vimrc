" 全般 {{{1
set nocompatible "vi互換モードをオフ
set shellslash   "パス区切りをスラッシュにする
set lazyredraw   "スクリプト実行中の描画を抑制
set splitright   "vsplitで新規ウィンドウは右側にする

"表示関係 {{{1
set t_Co=256     "256色ターミナル対応
colorscheme darkblue  " 色テーマ
set laststatus=2 "ステータスラインを常に表示

set tabstop=4    " タブは4スペース
set shiftwidth=4 "shiftwidth(sw) インデントの幅
set softtabstop=0 "softtabstop(sts) Tabキーを押したときに挿入される空白の量

set number       "行番号表示
set title        "ウィンドウのタイトルを書き換える
set cursorline   "カーソル行を強調表示

syntax on           "シンタックスハイライト
filetype indent on  "ファイルタイプによるインデントを行う
filetype plugin on  "ファイルタイプによるプラグインを使う

"入力関係 {{{1
set backspace=indent,eol,start  "BSでなんでも消せるようにする
set formatoptions+=mM           "整形オプションにマルチバイト系を追加
set autoindent
set smartindent

set wildmenu
set wildmode=list:longest
set completeopt=menu,preview,menuone

"検索関係 {{{1
set incsearch    "インクリメンタルサーチ
set nowrapscan   "ラップしない
set ignorecase   "大文字小文字無視
set smartcase    "大文字で始めたら大文字小文字を区別する
set hlsearch     "検索文字をハイライト表示

"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '¥¥/.*$^~[]')<CR><CR>
"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '¥¥/.*$^~[]')<CR>//gc<Left><Left><Left>

"カーソル下の文字コードを表示 {{{
"http://vimwiki.net/?tips%2F98
function! Getb()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Dec(c)
endfunction
function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc
func! String2Dec(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    if ix == 1
      let out = out . ','
    endif
    let out = out . printf('%3d', char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc
"}}}

"エンコーディング関係 {{{1

set fileformat=unix
set fileformats=unix,dos,mac
set encoding=utf-8
if has('win32')
  set encoding=cp932
  set fileencoding=utf-8
  set fileencodings=iso-2022-jp,euc-jp,utf-8,utf-16,ucs-2-internal,ucs-2
else
  set encoding=utf-8
  set termencoding=utf-8
  set fileencoding=utf-8
  set fileencodings=iso-2022-jp,cp932,euc-jp,utf-16,ucs-2-internal,ucs-2
endif

"文字コードの自動認識 {{{
"http://www.kawaz.jp/pukiwiki/?vim#content_1_7
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  "let s:enc_euc = 'euc-jp'
  let s:enc_euc = 'utf-8'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("¥x87¥x64¥x87¥x6a", 'cp932', 'eucjp-ms') ==# "¥xad¥xc5¥xad¥xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("¥x87¥x64¥x87¥x6a", 'cp932', 'euc-jisx0213') ==# "¥xad¥xc5¥xad¥xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^¥(euc-jp¥|euc-jisx0213¥|eucjp-ms¥)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^¥x01-¥x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
"}}}

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  else
    set ambiwidth=double
  endif
endif

"バックアップファイル, スワップファイル {{{1
set backup
if has('win32')
  if hostname() ==? 'LUNA'
    let s:backup_dir = 'D:/vim_backup'
  else
    let s:backup_dir = 'C:/vim_backup'
  endif
else
  let s:backup_dir = expand('~/.vim_backup')
endif
if !isdirectory(s:backup_dir)
  exec mkdir(s:backup_dir, '', 0700)
endif
"set backupext=.bak
let &backupdir = s:backup_dir
let &directory = s:backup_dir

"操作関係 {{{1
set scrolloff=10    "スクロール時に表示を5行確保

" 行折り返し \w
nnoremap <Leader>w  :set wrap!<CR>

"Ctrl+jkで5行ずつ移動
map <C-k> <Up><Up><Up><Up><Up>
imap <C-k> <Up><Up><Up><Up><Up>
map <C-j> <Down><Down><Down><Down><Down>
imap <C-j> <Down><Down><Down><Down><Down>

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

set grepprg=internal "内蔵grepを使う

" NeoBundle {{{1
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
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
" 部分検索用 {{{2
NeoBundle "https://github.com/kana/vim-operator-user"
NeoBundle "https://github.com/osyo-manga/vim-operator-search"
NeoBundle "https://github.com/kana/vim-textobj-user"
NeoBundle "https://github.com/kana/vim-textobj-function"

NeoBundle 'majutsushi/tagbar'

" 関数内の検索を行う
" require - https://github.com/kana/vim-textobj-function
nmap <Space>s <Plug>(operator-search)
nmap <Space>/ <Plug>(operator-search)if

filetype plugin indent on     " Required!
filetype indent on

" Installation check.
NeoBundleCheck

" start neocomplcache
let g:neocomplcache_enable_at_startup = 1

" ------ setting for neocomplcache {{{2

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" setting for neosnippet

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

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

"========== 各言語での実行
"for perl
" perlファイルを開いた時だけにしたい。
"command! Perl call s:Perl()
"nmap <F8> :Perl<CR>
"function! s:Perl()
"	:w
"		:!perl %
"endfunction
"command! Perlc call s:Perlc()
"nmap <F5> :Perlc<CR>
"function! s:Perlc()
"	:w
"		:!perl -c %
"endfunction

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
set modeline
set modelines=3
" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
