" This file should include all settings, maps, etc. related to cscope and ctags

" Look for a local cscope file if it exists or a cscope environment var
if has("cscope")
    " Check if cscope.out exists in the current directory and add it
    if filereadable("cscope.out")
        cs add cscope.out
    " Optionally, check an environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif
" Look for a local tags file if it exists or a tags environment var
if filereadable("tags")
    set tags+=./tags
elseif $TAGS_DB != ""
    set tags+=$TAGS_DB
endif

" Set cscope results to show up in quickfix window
" This lets us copy results from the quickfix window
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
" Maps
nnoremap <leader>b :tab cs find s <C-R>=expand("<cword>")<CR><CR>
vnoremap <leader>b y:tab cs find s <C-r>"<CR>
nnoremap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
vnoremap <leader>s y:cs find s <C-r>"<CR>
