"全般
set nocompatible
set shellslash   "パス区切りをスラッシュにする
set lazyredraw
set splitright   "vsplitで新規ウィンドウは右側にする
set t_Co=256

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
set mouse=a
set ttymouse=xterm2

set tags=tags       "タグファイル
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

"matchit
:source $VIMRUNTIME/macros/matchit.vim

"smooth-scroll.vim
"http://www.vim.org/scripts/script.php?script_id=1601
nmap <PageDown> <C-F>
nmap <PageUp> <C-B>

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

" ==== END SETTING
