set encoding=utf-8
scriptencoding utf-8

" エンコーディング {{{
set termencoding=utf-8 " ターミナルのエンコーディング
set fileencoding=utf-8 " 新規ファイルのエンコーディング
" ファイルエンコーディング
if ! (has('gui_macvim') && has('kaoriya'))
  set fileencodings=ucs-bom,utf-8,eucjp,cp932,ucs-2le,latin1,iso-2022-jp
endif
" }}}

" タブ {{{
set expandtab       " タブをスペースに展開する
set tabstop=2       " 画面上でタブ文字が占める幅
set softtabstop=2   " タブキーやバックスペースキーでカーソルが動く幅
set shiftwidth=2    " 自動インデントや <<, >> でずれる幅
set smarttab        " スマートなタブ切り替え
" }}}

" 検索 {{{
set incsearch    "インクリメンタルサーチ
set nowrapscan   "ラップしない
set ignorecase   "大文字小文字無視
set smartcase    "大文字で始めたら大文字小文字を区別する
set hlsearch     "検索文字をハイライト表示
" }}}

" インデントと整形 {{{
set autoindent       " 自動インデント
set smartindent      " スマートなインデント
set textwidth=0      " 自動改行はオフ
set formatoptions+=nmM " テキスト整形オプション
" 括弧付きの連番を認識する
set formatlistpat=^\\s*\\%(\\d\\+\\\|[-a-z]\\)\\%(\\\ -\\\|[]:.)}\\t]\\)\\?\\s\\+
" }}}

" 画面表示 {{{
set ambiwidth=single     " 文字幅の指定が曖昧なときは半角と見なす
set t_Co=256             " 256 色表示ターミナル対応
set showmatch            " 対応する括弧を自動的に装飾して表示
set laststatus=1         " ステータスラインは常に表示
set number               " 現在行の行番号を表示する
set numberwidth=3        " 行番号の幅は 3 桁
set showtabline=1        " tabline をタブが 2 つ以上あるときだけ表示する
set cmdheight=2          " 画面最下段のコマンド表示行数
" }}}

" カラースキーム {{{
syntax enable
"set background=light
"colorscheme solarized
set background=dark
colorscheme jellybeans
" }}}

" その他 {{{
set fileformat=unix               " 改行コード指定
set fileformats=unix,dos          " 改行コード自動認識
set wildmenu                      " コマンドラインモードでの補完メニュー
set helplang=ja                   " ヘルプは日本語のものを優先する
" 3,000 行を超えるようなバッファーではファイルタイプを無効にする
augroup NoFiletypeForHugeBuffer
  autocmd!
  autocmd BufRead,BufEnter * if line('$') > 3000 | set filetype= | endif
augroup END
" }}}
