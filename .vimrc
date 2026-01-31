set number
colorscheme desert
set nocompatible
packloadall

set nowrap
set cursorline
" Tags and cscope
set tags=./tags;,tags;
set csre

" Native plugins
packloadall

"vim plug
call plug#begin()

" List your plugins here
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Valloric/YouCompleteMe'

Plug 'https://github.com/aklt/plantuml-syntax'
Plug 'https://github.com/tyru/open-browser.vim.git'
Plug 'https://github.com/weirongxu/plantuml-previewer.vim.git'
Plug 'preservim/vim-markdown'
Plug 'https://github.com/grepsuzette/vim-sum.git'
Plug 'https://github.com/gcmt/taboo.vim.git'
Plug 'https://github.com/jiangmiao/auto-pairs.git'
Plug 'https://github.com/tpope/vim-surround.git' 
call plug#end()

"Plugin settings

"YCM settings
let g:ycm_auto_trigger=1
let g:ycm_enable_semantic_highlighting=1
" exec 'let g:ycm_auto_trigger'
" exec 'let g:ycm_enable_semantic_highlighting=1'

" Enable PlantUML support in the preview
let g:mkdp_plantuml = 1"
let g:markdown_fenced_languages = ['plantuml']

"VimSum settings
nmap <Leader>a <Plug>VimSumOperatorPending
vmap <Leader>a <Plug>VimSumVisual
" Taboo tab settings
set sessionoptions+=tabpages,globals

"Functions
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

" Define a custom command to call the function easily
command! TrimSpaces call TrimTrailingWhiteSpace()


" Maps
" Enter adds a new line below.
map <Enter> o<ESC>
" Shift-Enter adds a new line above.
map <S-Enter> O<ESC>
" Map Ctrl+c to yank to the system clipboard
nnoremap <C-c> "+y
vnoremap <C-c> "+y
snoremap <C-c> "+y
" Map ; to launch FZF file find" 
map ; :Files<CR>
" cscope 
"Use leader b for new tabs
nnoremap <leader>b :tab cs find s <C-R>=expand("<cword>")<CR><CR>
vnoremap <leader>b y:tab cs find s <C-r>"<CR>
" Use Ctrl S to launch cs find s
nnoremap <C-s> :cs find s <C-R>=expand("<cword>")<CR><CR>
vnoremap <C-s> y:cs find s <C-r>"<CR>

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

