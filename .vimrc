set number
colorscheme desert
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
Plug 'preservim/vim-markdown'
Plug 'https://github.com/grepsuzette/vim-sum.git'
Plug 'https://github.com/gcmt/taboo.vim.git'
Plug 'https://github.com/jiangmiao/auto-pairs.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-commentary.git' 
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline' 
Plug 'tpope/vim-fugitive'
Plug 'bullets-vim/bullets.vim'
Plug 'chrisbra/csv.vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-eunuch'
" Collection of common snippets 
Plug 'honza/vim-snippets'
call plug#end()

"Plugin settings

" Vim Airline
" Turn off all extensions. 
" There was slow down typing when in insert mode and ycm autocomplete
" Safer to turn off all extensions and add back by one as needed
let g:airline_extensions = ['tagbar']
" Airline tagbar
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
"YCM settings
let g:ycm_auto_trigger=1
let g:ycm_enable_semantic_highlighting=1

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

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"Fugitive git. Use windows git
let g:fugitive_git_executable = '"/mnt/c/Program Files/Git/cmd/git.exe"'

"Markdown server local
let g:mkdp_preview_options = {
    \ 'uml': { 'server': 'http://localhost:8080',  'imageFormat': 'svg' }
    \ }
"End Plugin settings



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
nnoremap <C-c> "+y
vnoremap <C-c> "+y
snoremap <C-c> "+y
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
