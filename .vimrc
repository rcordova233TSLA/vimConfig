source ./Plugins.vim

source ./Common/CommonMaps.vim
source ./Common/Utilities.vim

"{{{ General
set nocompatible
colorscheme habamax
if !exists("g:syntax_on")
    " Stops vim from messing with syntax if it already enabled it
    " Was getting weird behavior with plantuml syntax in md files
    " If I sourced vimrc and this command got called repeatedly
    syntax enable
endif
set mouse=a
set showcmd "show (partial) command in status line

set number
set nowrap
set cursorline

"}}}

" Enable local vimrcs for local project options
set exrc      " Enable reading of local .vimrc files
set secure    " Use 'secure' mode to disable potentially unsafe commands

" Path finding
set path+=**
set wildmenu

" Whitespace detector: use set list to view all whitespace and returns
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

"Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab
set autoindent          " copy indent from current line when starting a new line
set backspace=indent,eol,start

" Quickfix
autocmd FileType qf nnoremap <buffer> <CR> :exe 'wincmd p \| '. line('.'). 'cc'<CR>
autocmd FileType qf wincmd K
