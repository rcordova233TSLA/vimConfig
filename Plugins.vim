" This is the list of all plugins that are being used
" Vim-plug is the preferred manager currently
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
Plug 'dhruvasagar/vim-table-mode'
Plug 'dense-analysis/ale'
" Collection of common snippets 
Plug 'honza/vim-snippets'
call plug#end()
