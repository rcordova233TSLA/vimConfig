" Turn off all extensions. 
" There was slow down typing when in insert mode and ycm autocomplete
" Safer to turn off all extensions and add back by one as needed
let g:airline_extensions = ['tagbar']
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
