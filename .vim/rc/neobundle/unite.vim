" setting for unite
" - keymap 
"   <Space> u ..
"      f : file
"      b : buffer
"
"      y : yank
"
NeoBundle 'https://github.com/Shougo/unite.vim'

let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

nnoremap <Space>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <Space>ub :<C-u>Unite buffer<CR>
nnoremap <Space>uy :<C-u>Unite history/yank<CR>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
