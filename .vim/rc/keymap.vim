set encoding=utf-8
scriptencoding utf-8

"操作関係 {{{1
set scrolloff=10    "スクロール時に表示を5行確保

" 行折り返し \w
nnoremap <Leader>w  :set wrap!<CR>

"カーソルで4行ずつ移動
nnoremap <Up> 4k
nnoremap <Down> 4j

"表示行単位で移動
"noremap j gj
"noremap k gk
"noremap gj j
"noremap gk k

"挿入モードのカーソル移動
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <Left>
inoremap <M-l> <Right>

"最後に変更されたテキストを選択
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>
