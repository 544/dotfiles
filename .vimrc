
" Setting for Neobundle Plugin
set nocompatible               " Be iMproved

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
 " My Bundles here:
NeoBundle 'scrooloose/nerdtree'
 "
 " Note: You don't set neobundle setting in .gvimrc!
 " Original repos on github
 "NeoBundle 'tpope/vim-fugitive'
 "NeoBundle 'Lokaltog/vim-easymotion'
 "NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
 "" vim-scripts repos
 "NeoBundle 'L9'
 "NeoBundle 'FuzzyFinder'
 "NeoBundle 'rails.vim'
 "" Non github repos
 "NeoBundle 'git://git.wincent.com/command-t.git'
 "" gist repos
 "NeoBundle 'gist:Shougo/656148', {
 "      \ 'name': 'everything.vim',
 "      \ 'script_type': 'plugin'}
 "" Non git repos
 "NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
 "NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'

 filetype plugin indent on     " Required!
 "
 " Brief help
 " :NeoBundleList          - list configured bundles
 " :NeoBundleInstall(!)    - install(update) bundles
 " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

 " Installation check.
 NeoBundleCheck

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
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
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

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
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

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

" For Unite
NeoBundle 'Shougo/unite.vim'








"全般
set nocompatible
set viminfo+=!   "yankring用に!を追加
"set shellslash   "パス区切りをスラッシュにする
set lazyredraw
set splitright   "vsplitで新規ウィンドウは右側にする
set t_Co=256
"colorscheme rdark
"colorscheme desert
"set background=dark
"colorscheme peaksea
"colorscheme rootwater
"colorscheme edark
"let edark_current_line=1
"let edark_ime_cursor=1
"let edark_insert_status_line=1

"edark
"http://eureka.pasela.org/

"Low-Contrast Color Schemes
"http://www.vim.org/scripts/script.php?script_id=1448

"rdark
"http://www.vim.org/scripts/script.php?script_id=1732

"ChocolateLiquor
"http://www.vim.org/scripts/script.php?script_id=592

"peaksea
"http://www.vim.org/scripts/script.php?script_id=760

"rootwater
"http://www.vim.org/scripts/script.php?script_id=2350

"tango-desert
"http://www.vim.org/scripts/script.php?script_id=2671

"バッファで編集中のファイルがあるディレクトリに移動
"autocmd BufEnter * if bufname("") !~ "^¥[A-Za-z0-9¥]://" | silent! lcd %:p:h | endif

"Tab関係
"tabstop(ts) Tab文字を画面上で何文字に展開するか
set tabstop=4
"shiftwidth(sw) インデントの幅
set shiftwidth=4
"softtabstop(sts) Tabキーを押したときに挿入される空白の量
set softtabstop=0
"expandtab(et) Tab文字を空白に展開
"set expandtab

"入力関係
set backspace=indent,eol,start  "BSでなんでも消せるようにする
set formatoptions+=mM           "整形オプションにマルチバイト系を追加
set autoindent
set smartindent

"コマンド補完
set wildmenu
set wildmode=list:longest
set completeopt=menu,preview,menuone

"補完候補を出したまま改行できるようにする
"inoremap <expr> <CR> pumvisible() ? "¥<C-Y>¥<CR>" : "¥<CR>"
"Enterで補完決定にする
"inoremap <expr> <CR> pumvisible() ? "¥<C-Y>" : "¥<C-G>u¥<CR>"
"ESCで補完キャンセルして元のテキストに戻す  ※.gvimrcで<ESC>を上書きしてるので動かない
"inoremap <expr> <ESC> pumvisible() ? "¥<C-E>" : "¥<ESC>"
"インクリメンタルに候補を絞り込み、Enterで決定
"inoremap <expr> <C-N> pumvisible() ? "¥<lt>C-N>" : "¥<C-N>¥<C-R>=pumvisible() ? ¥"¥¥<lt>Down>¥" : ¥"¥"¥<lt>CR>"

"検索関係
set incsearch    "インクリメンタルサーチ
set nowrapscan   "ラップしない
set ignorecase   "大文字小文字無視
set smartcase    "大文字で始めたら大文字小文字を区別する
set hlsearch     "検索文字をハイライト表示

"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '¥¥/.*$^~[]')<CR><CR>
"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '¥¥/.*$^~[]')<CR>//gc<Left><Left><Left>

"表示関係
set number       "行番号表示
"set ruler        "ルーラー表示(ステータスライン変えてるから意味ない)
set title        "ウィンドウのタイトルを書き換える

"カレントウィンドウのみカーソル行をハイライト
"autocmd WinEnter * setlocal cursorline
"autocmd WinLeave * setlocal nocursorline
set cursorline   "カーソル行を強調表示

"特殊文字(SpecialKey)の見える化
"set list
"set listchars=tab:>.,trail:_,nbsp:%,extends:>,precedes:<

"カーソル下の文字コード
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

"ステータスライン関係
set laststatus=2 "ステータスラインを常に表示
"set statusline=%y=[%{&fileencoding}][¥%{&fileformat}]¥ %F%m%r%=<%c:%l>
"ファイルパス [filetype][fenc][ff]    桁(ASCII=10進数,HEX=16進数) 行/全体(位置)[修正フラグ]
"set statusline=%<%F¥ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%{Getb()},HEX=%{GetB()})¥ %l/%L(%P)%m

"エンコーディング関係
set fileformat=unix
set fileformats=unix,dos,mac
set encoding=utf-8
"if has('win32')
"  set encoding=cp932
"  set fileencoding=utf-8
"  set fileencodings=iso-2022-jp,euc-jp,utf-8,utf-16,ucs-2-internal,ucs-2
"else
"  set encoding=utf-8
"  set termencoding=utf-8
"  set fileencoding=utf-8
"  set fileencodings=iso-2022-jp,cp932,euc-jp,utf-16,ucs-2-internal,ucs-2
"endif

"文字コードの自動認識
"http://www.kawaz.jp/pukiwiki/?vim#content_1_7
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
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

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  else
    set ambiwidth=double
  endif
endif

"ファイルタイプ関係
syntax on           "シンタックスハイライト
filetype indent on  "ファイルタイプによるインデントを行う
filetype plugin on  "ファイルタイプによるプラグインを使う

"バックアップファイル, スワップファイル
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

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
"http://www.kawaz.jp/pukiwiki/?vim#ib970976
"augroup BinaryXXD
"  autocmd!
"  autocmd BufReadPre  *.bin let &binary =1
"  autocmd BufReadPost * if &binary | silent %!xxd -g 1
"  autocmd BufReadPost * set ft=xxd | endif
"  autocmd BufWritePre * if &binary | %!xxd -r
"  autocmd BufWritePre * endif
"  autocmd BufWritePost * if &binary | silent %!xxd -g 1
"  autocmd BufWritePost * set nomod | endif
"augroup END

"操作関係
set scrolloff=10    "スクロール時に表示を5行確保

"Ctrl+上下で5行ずつ移動
map <C-Up> <Up><Up><Up><Up><Up>
imap <C-Up> <Up><Up><Up><Up><Up>
map <C-Down> <Down><Down><Down><Down><Down>
imap <C-Down> <Down><Down><Down><Down><Down>

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

"タブ切り替え
nnoremap <C-Tab>   gt
nnoremap <C-S-Tab> gT

"マウス関係
"set mouse=a
"set ttymouse=xterm2

"set tags=tags       "タグファイル
set grepprg=internal "内蔵grepを使う

"編集中のファイルのあるディレクトリに移動
au BufEnter * exec ':lcd %:p:h'

"TOhtmlコマンドの設定
"let g:html_number_lines = 0
"let g:html_ignore_folding = 1
let g:html_use_css = 1
"let g:html_no_pre = 0
"let g:html_use_encoding = 'utf8'
let g:html_use_xhtml = 1


"========== プラグイン設定 ==========

"autocomplpop
"http://www.vim.org/scripts/script.php?script_id=1879
let g:AutoComplPop_NotEnableAtStartup=1
let g:AutoComplPop_MappingDriven=1
autocmd FileType * let g:AutoComplPop_CompleteOption='.,w,b,u,t,i'
autocmd FileType php let g:AutoComplPop_CompleteOption='.,w,b,u,t,k$VIM/vimfiles/dict/php.dict'

"PHP辞書
"http://www.asahi-net.or.jp/~wv7y-kmr/memo/vim_php.html

"taglist
"http://www.vim.org/scripts/script.php?script_id=273
"if has('win32')
"  let Tlist_Ctags_Cmd="ctags.exe"
"else
"  let Tlist_Ctags_Cmd="ctags"
"endif
"let Tlist_Show_One_File=1
"let Tlist_Exit_OnlyWindow=1
"let Tlist_Use_Right_Window=1
"let tlist_php_settings = 'php;c:class;d:constant;f:function'
"map <silent> <leader>tl :TlistToggle<CR>

"bufexplorer
"http://www.vim.org/scripts/script.php?script_id=42
"map <silent> <leader>bl :BufExplorer<CR>

"winmanager
"http://www.vim.org/scripts/script.php?script_id=95
"http://www.vim.org/scripts/script.php?script_id=1440
let g:winManagerWindowLayout = 'FileExplorer,TagList'
let g:explSplitRight=1
let g:explStartRight=1
let g:explDateFormat='%Y-%m-%d %H:%M:%S'

map <C-w><C-f> :<C-u>FirstExplorerWindow<CR>
map <C-w><C-b> :<C-u>BottomExplorerWindow<CR>
map <C-w><C-t> :<C-u>WMToggle<CR>

"matchit
:source $VIMRUNTIME/macros/matchit.vim

"mru.vim
"http://www.vim.org/scripts/script.php?script_id=521
let MRU_Max_Entries=20

"smooth-scroll.vim
"http://www.vim.org/scripts/script.php?script_id=1601
"nmap <PageDown> <C-F>
"nmap <PageUp> <C-B>

"evalbuffer.vim
"http://eureka.pasela.org/
vmap <silent> <F10> :<C-u>EvalBuffer<CR>
"nmap <silent> <F10> mzggVG<F10>`z
nmap <silent> <F10> :<C-u>EvalBuffer<CR>
map  <silent> <S-F10> :<C-u>pc<CR>

"bwTemplate.vim
"http://www.vim.org/scripts/script.php?script_id=1411
if has('win32')
  let g:bwTemplateDir=substitute($VIM . '¥vimfiles¥templates¥', '¥', '/', 'g')
else
  let g:bwTemplateDir=$HOME . '/.vim/templates/'
endif
let g:bwTemplate_author='Yuki'
let g:bwTemplate_email='paselan at Gmail.com'
nnoremap <unique> <F4> :<C-u>WTemplate<CR>
nnoremap <unique> <S-F4> :<C-u>WTemplateList<CR>

"project.vim
"http://www.vim.org/scripts/script.php?script_id=69
let g:proj_flags="imstg"

"Align.vim
"http://www.vim.org/scripts/script.php?script_id=294
let g:Align_xstrlen=3

"surround.vim
"http://www.vim.org/scripts/script.php?script_id=1697

"eregex.vim
"http://www.vector.co.jp/soft/unix/writing/se265654.html

"vcscommand.vim
"http://www.vim.org/scripts/script.php?script_id=90

"yankring.vim
"http://www.vim.org/scripts/script.php?script_id=1234

"svn-diff.vim
"http://www.vim.org/scripts/script.php?script_id=978

"grep.vim
"http://www.vim.org/scripts/script.php?script_id=311

"phpmanual.vim
"http://www.asahi-net.or.jp/~wv7y-kmr/tools/phpmanual.html
let phpmanual_convfilter='cat'
let phpmanual_htmlviewer='w3m -O "EUC-JP" -T text/html'
let phpmanual_use_ext_browser=1
let phpmanual_ext_command='PHPBrowser'
let phpmanual_ext_browser_cmd='firefox'

"monday.vim
"http://www.vim.org/scripts/script.php?script_id=1046

"commentout.vim
"http://nanasi.jp/articles/vim/commentout_source.html

"AutoClose.vim
"http://www.vim.org/scripts/script.php?script_id=1849
"IMとの相性が悪いようなので解決策が見つかるまで無効にする
"let g:autoclose_on=0

"colorsel.vim
"http://www.vim.org/scripts/script.php?script_id=927

"ScreenShot_mb.vim
"http://nanasi.jp/articles/vim/screenshot_vim.html
let g:ScreenShot = {'Title':1, 'Icon':0, 'Credits':0, 'fill_screen':0}

"Chalice
"http://www.kaoriya.net/
set runtimepath+=$VIM/vimfiles/chalice

"TwitVim
"http://www.vim.org/scripts/script.php?script_id=2204
let twitvim_api_root = 'https://twitter.com'
let twitvim_cert_insecure = 1
let twitvim_login_b64 = 'IDとパスワード'
let twitvim_browser_cmd = 'C:¥Program Files¥Mozilla Firefox¥firefox.exe'
let twitvim_count = 50

"========== 各言語での実行
"for perl
command! Perl call s:Perl()
nmap <F8> :Perl<CR>
function! s:Perl()
	:w
		:!perl %
	endfunction

"========== プライベートな拡張 ==========

"memo
function! Memo()
  if has('win32')
    if hostname() ==? 'LUNA'
      :tabnew D:/memo.lst
    else
      :tabnew C:/memo.lst
    endif
  else
    :tabnew ~/memo.lst
  endif
endf
command! Memo :call Memo()

"日付挿入
function! InsertCDate(format)
  let old_lc_time = v:lc_time
  try
    exec ':silent! lang time C'
    let datetime = strftime(a:format)
    return datetime
  finally
    exec ':silent! lang time ' . old_lc_time
  endtry
endf
"YYYY-MM-DD HH:MM:SS
inoremap <Leader>date <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR>
nnoremap <Leader>date i<C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR><ESC>
vnoremap <Leader>date s<C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR><ESC>
"RFC2822(WDay, DD Month YYYY HH:MM:SS +-Timezone)
if has('win32')
  "Windowsの%zは「東京 (標準時)」とか返してきて+0900が得られない……
  inoremap <Leader>dt822 <C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S +0900')<CR>
  nnoremap <Leader>dt822 i<C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S +0900')<CR><ESC>
  vnoremap <Leader>dt822 s<C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S +0900')<CR><ESC>
else
  inoremap <Leader>dt822 <C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S %z')<CR>
  nnoremap <Leader>dt822 i<C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S %z')<CR><ESC>
  vnoremap <Leader>dt822 s<C-R>=InsertCDate('%a, %d %b %Y %H:%M:%S %z')<CR><ESC>
endif

"HTML整形
function! HTMLFormat()
  let l:reg_slash = @/
  exec '%s/></>¥r</g'
  normal! ggVG=
  let @/ = l:reg_slash
endf
command! HTMLFormat :call HTMLFormat()

"ファイル末尾に改行を付けずに保存
function! WriteNoEOL()
  let l:old_bin = &binary
  let l:old_eol = &endofline
  set binary
  set noendofline
  exec ':w'
  let &binary = l:old_bin
  let &endofline = l:old_eol
endf
command! WriteNoEOL :call WriteNoEOL()


" vim:set ts=2 sts=2 sw=2 et:


" for ctags;
set tags=/home/game/git/sg-ffjm/pm/Ffjm/tags,
