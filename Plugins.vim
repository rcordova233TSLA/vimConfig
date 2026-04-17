source ~/vimConfig/Common/Os.vim
" Vim-plug is the preferred manager currently
" Use fold marker method. Commented means it's on
" vim: set fdm=marker:
call plug#begin()
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'https://github.com/aklt/plantuml-syntax'
Plug 'https://github.com/tyru/open-browser.vim.git'
Plug 'preservim/vim-markdown'
Plug 'grepsuzette/vim-sum.git'
Plug 'gcmt/taboo.vim.git'
Plug 'jiangmiao/auto-pairs.git'
Plug 'tpope/vim-surround.git'
Plug 'tpope/vim-commentary.git' 
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline' 
Plug 'tpope/vim-fugitive'
Plug 'bullets-vim/bullets.vim'
Plug 'SirVer/ultisnips'
" Linux command wrappers in vim
Plug 'tpope/vim-eunuch'
Plug 'dhruvasagar/vim-table-mode'
Plug 'dense-analysis/ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'adelarsq/vim-pomodoro'
call plug#end()

"{{{ UltiSnips 
let g:UltiSnipsSnippetDirectories=[$HOME."/vimConfig/Snippets/"]
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
inoremap <C-U> <Esc>:Snippets<CR>
let g:UltiSnipsEditSplit="vertical"
"}}}

"{{{ ALE

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 0
if IsWSL()
    " For some reason ruff doesn't work in WSL, as of 04/08/2026
    let g:ale_linters = {
    \   'python': ["flake8","ruff"],
    \}
    let g:ale_python_flake8_use_global = 1
    let g:ale_python_flake8_options = '--config ~/.config/flake8'
else
    let g:ale_linters = {
    \   'python': ["ruff"],
    \}
endif
let g:ale_python_ruff_options = '--config ~/.config/ruff/ruff.toml'
let g:ale_fixers = {'python': ['ruff_format']}

command! PyF ALEFix ruff ruff_format
"}}}

"{{{ Airline Status Bar

if IsWSL()
    " Turn off all extensions. 
    " There was slow down typing when in insert mode and ycm autocomplete
    " Safer to turn off all extensions and add back by one as needed
    let g:airline_extensions = ['tagbar']
    let g:airline#extensions#tagbar#enabled = 1
endif
let g:airline#extensions#tagbar#flags = 'f'
"}}}

"{{{ TabooRename Tab
set sessionoptions+=tabpages,globals
"}}}

"{{{ Fugitive Git
if IsWSL()
    let g:fugitive_git_executable = '"/mnt/c/Program Files/Git/cmd/git.exe"'
endif
"}}}

"{{{ Gutentag
let g:gutentags_enabled = 1

let g:gutentags_modules = ['ctags', 'cscope']
" Define project roots
let g:gutentags_project_root = ['.root', '.git']

" Cache directory to keep projects clean
let g:gutentags_cache_dir = expand('~/.ctags_cache')

" Generate tags on save, new file, or missing
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
"}}}

"{{{ VimBullets
let g:bullets_outline_levels = ['num', 'std*']
"}}}

"{{{ VimSum
nmap <Leader>a <Plug>VimSumOperatorPending
vmap <Leader>a <Plug>VimSumVisual
"}}}

"{{{ YCM
let g:ycm_auto_trigger = 0
let g:ycm_enable_semantic_highlighting=1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_seed_identifiers_with_syntax = 1
" Hide preview
set completeopt-=preview
"}}}

"{{{ Ctags and Cscope

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
" Prevent tags from slowing down <C-n> autocomplete
"set complete-=t
"}}}
