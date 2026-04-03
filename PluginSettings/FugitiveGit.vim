source ./Common/Os.vim
if IsWSL()
    let g:fugitive_git_executable = '"/mnt/c/Program Files/Git/cmd/git.exe"'
endif
