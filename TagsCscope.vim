" This file should include all settings, maps, etc. related to cscope and ctags

" Set cscope results to show up in quickfix window
" This lets us copy results from the quickfix window
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
" Maps
nnoremap <leader>b :tab cs find s <C-R>=expand("<cword>")<CR><CR>
vnoremap <leader>b y:tab cs find s <C-r>"<CR>
nnoremap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
vnoremap <leader>s y:cs find s <C-r>"<CR>
