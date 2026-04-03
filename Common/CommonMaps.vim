" Enter adds a new line below.
nnoremap <leader>o o<ESC>
" Shift-Enter adds a new line above.
nnoremap <leader>O O<ESC>
" Copy file path from root of vim
nnoremap <leader>f :let @"=expand('%')<CR>
" Map Ctrl+c to yank to the system clipboard
vnoremap <C-c> "+y
" Map ; to launch FZF file find"
map ; :Files<CR>
