" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {
\   'python': ["flake8","ruff"],
\}
let g:ale_fixers = {
\   'python': ['ruff_format'],
\}
let g:ale_python_ruff_options = '--config ~/.config/ruff/ruff.toml'
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_python_flake8_use_global = 1
let g:ale_python_flake8_options = '--config ~/.config/flake8'
" Performance
let g:ale_completion_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 0
" Disable while typing too slow
" Default is 200m
" let g:ale_lint_delay = 1000

" Shortcuts/commands
command! PyF ALEFix ruff ruff_format
