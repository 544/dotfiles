" ウインドウの幅
set columns=100
" ウインドウの高さ
set lines=52
" コマンドラインの高さ(GUI使用時)
set cmdheight=1
let s:ext = fnamemodify(bufname(""), ":e")

"Mail.appの外部エディタとしての使用
if s:ext=="mail"
set columns=80
set lines=40
end

"Safari.appの外部エディタとして使用"
if s:ext=="safari"
set columns=80
set lines=40
end


" マウスに関する設定:
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
set guioptions+=a

set number
set incsearch
set autoindent
set ic
set ts=4
set noexpandtab
set shiftwidth=4

"リマップ関連
inoremap ¥ \
"<ESC>
inoremap <C-q> <Esc>
vnoremap <C-q> <Esc>

"<移動>
inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-b> <S-Left>
inoremap <C-w> <S-Right>
inoremap <C-x> <BS>

"<cm>によってコメントアウト
nmap cm :call EnhancedCommentify('', 'guess')<CR>

"補完ウィンドウの色
highlight Pmenu guibg=#666666
highlight PmenuSel guibg=#AA0000 guifg=#FFFFFF

"vi-latexプラグインに関する設定
filetype plugin on
filetype indent on
"ファルタイプが.texの時のみスペルチェックする
autocmd FileType tex set spell

"Octave, Matlab用にリマップ
if s:ext=="m"
"括弧の補完
inoremap ( ()<++>5<LEFt>
inoremap { {}<++>5<LEFt>
inoremap [ []<++>5<LEFt>
inoremap '' ''<++>5<LEFT>
"行末に;を挿入
nmap ; <S-a>;<ESC>0
end

"インクリメントコピー，数字部分だけをインクリメントしてコピーする．
map <C-I> Yp:s/\d\+/\=(submatch(0)+1)/g<CR>

"インプットモード内で<C-w>で単語毎のbackspace
inoremap <C-w> <ESC>bdwa

"vim-cocoaとMacVimの共通設定
if has('mac')
set showtabline=2 " タブを常に表示
set guioptions-=T
set guioptions+=ai
autocmd VimEnter * tab all
set transparency=30 " 透明度を指定

set formatoptions+=m
set backspace=indent,eol,start
set wildmenu
set wildmode=list:full
set noswapfile
set showcmd
set ffs=unix,dos,mac

set complete+=k " 補完に辞書ファイル追加
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp

set smarttab "行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。

"フォント関連
set guifont=Courier:h12
set guifontwide=Courier:h12
set antialias

colorscheme desert
hi NonText guibg=NONE guifg=NONE
hi Normal guibg=grey5
hi LineNr gui=bold
hi LineNr guifg=#DDDDDD

highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey "全角スペースの可視化

"ステータスラインの設定
set laststatus=2 "表示
set statusline=%t<%<%F>%m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l-%c[%p%%]
"ステータスラインの色
highlight StatusLine term=NONE cterm=NONE guifg=white guibg=NONE gui=bold
highlight StatusLineNC term=NONE cterm=NONE guifg=grey50 guibg=NONE
" highlight StatusLineNC cterm=reverse

"検索ハイライトの色
highlight IncSearch guifg=white guibg=black
highlight Search guifg=white guibg=blue

"カーソルの色
highlight Cursor guibg=white guifg=black

"vsplit時の境界の色
highlight VertSplit guifg=black guibg=NONE
" set fillchars=vert:I

"折りたたみ
highlight Folded guibg=gray10

"スクロールバーの非表示
set guioptions-=r
set guioptions-=L

"行送り
set scrolloff=10

"<C-e><C-y>によるスクロールを速くする
nnoremap <C-e> <C-e><C-e><C-e><C-e>
nnoremap <C-y> <C-y><C-y><C-y><C-y>

"OSのクリップボードとリンクさせる
nmap _ :.w !nkf -Ws\|pdcopy<CR><CR>
vmap _ :w !nkf -Ws\|pdcopy<CR><CR>

set visualbell

"タブ移動リマップ
nnoremap t gt
nnoremap T gT

"セパレートウィンドウを切り替えをリマップ
nnoremap <C-w> <C-w><C-w>

"NERDTreeの表示と非表示
let NERDTreeWinPos="right"
let NERDTreeWinSize=25

"vim-cocoa用のサイズ
set columns=1000
set lines=1000
endif

" MacVim用
if has('gui_macvim')
set columns=100
set lines=52
set transparency=30 " 透明度を指定

map <silent> gw :macaction selectNextWindow:
map <silent> gW :macaction selectPreviousWindow:

" フルスクリーン切り替え関数
function! FullAndHideTab()
set fuoptions=maxvert,maxhorz
set invfullscreen 
set transparency=50
if &showtabline==0
set showtabline=2
"set columns=columns
"set lines=lines
set fuoptions=lines,columns
set transparency=30
else
set showtabline=0
end
endfunction
nnoremap <silent><space>f :call FullAndHideTab()
endif

" Windows用gvim-kaoriya
if has('win32')
colorscheme desert
set transparency=200
nmap ; :
set guioptions=-c
"IME状態に応じたカーソル色を設定
if has('multi_byte_ime')
highlight Cursor guifg=#000d18 guibg=#8faf9f gui=bold
highlight CursorIM guifg=NONE guibg=#ecbcdc
end
set guifont=MS_Gothic:h11:cSHIFTJIS
set linespace=1
if has('kaoriya')
set ambiwidth=auto
endif
end
