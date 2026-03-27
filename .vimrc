set number
colorscheme habamax
set nocompatible
" Use enable instead of on to avoid default highlighting overwriting plantuml
" syntax
if !exists("g:syntax_on")
    syntax enable
endif
set nowrap
set cursorline
" Sources
source ~/vimConfig/TagsCscope.vim
source ~/vimConfig/Plugins.vim
source ~/vimConfig/UltiSnipsConfig.vim
source ~/vimConfig/YCMConfig.vim
source ~/vimConfig/AleLint.vim
" Vim Airline
" Turn off all extensions. 
" There was slow down typing when in insert mode and ycm autocomplete
" Safer to turn off all extensions and add back by one as needed
let g:airline_extensions = ['tagbar']
" Airline tagbar
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'

" Enable PlantUML support in the preview
let g:mkdp_plantuml = 1
let g:markdown_fenced_languages = ['plantuml']

"VimSum settings
nmap <Leader>a <Plug>VimSumOperatorPending
vmap <Leader>a <Plug>VimSumVisual
" Taboo tab settings
set sessionoptions+=tabpages,globals
"Vim Bullets
let g:bullets_outline_levels = ['num', 'std*']


"Fugitive git. Use windows git
let g:fugitive_git_executable = '"/mnt/c/Program Files/Git/cmd/git.exe"'

"Markdown server local
let g:mkdp_preview_options = {
    \ 'uml': { 'server': 'http://localhost:8080',  'imageFormat': 'svg' }
    \ }
"End Plugin settings



"Functions
" Gather search hits, and display in a new scratch buffer.
function! Gather(pattern)
    if !empty(a:pattern)
        let save_cursor = getpos(".")
        let orig_ft = &ft
        " append search hits to results list
        let results = []
        execute "g/" . a:pattern . "/call add(results, line('.') . ': ' . getline('.'))"
        call setpos('.', save_cursor)
        if !empty(results)
          " put list in new scratch buffer
          split
          enew
          setlocal buftype=nofile bufhidden=hide noswapfile
          execute "setlocal filetype=".orig_ft
          call append(1, results)
          1d  " delete initial blank line
          " remove Windows ^M characters
          silent! %s/\r//g
        endif
    endif
endfunction

" Delete the current buffer if it is a scratch buffer (any changes are lost).
function! CloseScratch()
  if &buftype == "nofile" && &bufhidden == "hide" && !&swapfile
    " this is a scratch buffer
    bdelete
    return 1
  endif
  return 0
endfunction
command! -nargs=1 FilterPattern call Gather(<f-args>)<CR>
command! Filter call Gather(@/)<CR>

function! TrimTrailingWhiteSpace() abort
  " Save the current cursor position and view
  let l:view = winsaveview()
  " Save the last search pattern
  let l:old_query = getreg('/')
  " Perform the substitution: %s/\\s\\+$//e
  " %s applies to all lines, \\s\\+$ finds one or more whitespace chars at line end, // replaces with nothing
  " :silent! prevents "X substitutions on Y lines" message
  " :keeppatterns prevents clobbering the search history
  silent! keeppatterns %s/\s\+$//e
  " Restore the last search pattern
  call setreg('/', l:old_query)
  " Restore the cursor position and view
  call winrestview(l:view)
endfunction
function! CloseHiddenBuffers()
    " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    " close any buffers hidden
    " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    let open_buffers = []

    for i in range(tabpagenr('$'))
        call extend(open_buffers, tabpagebuflist(i + 1))
    endfor

    for num in range(1, bufnr("$") + 1)
        if buflisted(num) && index(open_buffers, num) == -1
            exec "bdelete ".num
        endif
    endfor
endfunction

au BufEnter * call CloseHiddenBuffers()
" Define a custom command to call the function easily
command! StopAllMarkdownPreview bufdo if &ft == 'markdown' | execute "MarkdownPreviewStop" | update | endif
command! CloseHiddenBuffers call CloseHiddenBuffers()
command! TrimSpaces call TrimTrailingWhiteSpace()
command! RemoveDos %s///g
command! RemoveDosAddCr %s//\r/g
" Maps
" Enter adds a new line below.
nnoremap <leader>o o<ESC>
" Shift-Enter adds a new line above.
nnoremap <leader>O O<ESC>
" File scope autocomplete
"inoremap <C-k> <C-X><C-N>
" Map to copy filename to unamed buffer
nnoremap <leader>f :let @"=expand('%:r')<CR>
" Map Ctrl+c to yank to the system clipboard
vnoremap <C-c> "+y
" WSL Only
" vmap <C-c>  :w !clip.exe
" Map ; to launch FZF file find"
map ; :Files<CR>
" End Maps

" Enable local vimrcs for local project options
set exrc      " Enable reading of local .vimrc files
set secure    " Use 'secure' mode to disable potentially unsafe commands

" Switch localdirrectory to file open in buffer
" autocmd BufEnter * lcd %:p:h


"Path finding
set path+=**
set wildmenu

"Mouse scrolling
set mouse=a

" Macros
let @q = 'i|j'
" Whitespace detector: use set list to view all whitespace and returns
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" Quickfix window: open result in previous window
autocmd FileType qf nnoremap <buffer> <CR> :exe 'wincmd p \| '. line('.'). 'cc'<CR>
" Quickfix open at top
autocmd FileType qf wincmd K

"Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab
set autoindent          " copy indent from current line when starting a new line
" make backspaces more powerfull
set backspace=indent,eol,start
set showcmd             " show (partial) command in status line

" Autocomplete
" Don't look through includes
"setglobal complete-=i
