# Change to look for WSL var WSL_DISTRO_NAME
" Detect if running in Windows Subsystem for Linux (WSL)
function! IsWSL()
    if has("unix")
        let lines = readfile("/proc/version")
        if lines[0] =~ "Microsoft"
            return 1
        endif
    endif
    return 0
endfunction

" Environment-specific settings
if IsWSL()
    " WSL-specific configurations
    " e.g., perhaps for clipboard integration or terminal settings
    " For example, to use the Windows clipboard, you might use win32yank if installed
    " let g:clipboard = {
    "      \   'name': 'win32yank',
    "      \   'copy': {
    "      \     '+': 'win32yank.exe -i --crlf',
    "      \     '*': 'win32yank.exe -i --crlf',
    "      \   },
    "      \   'paste': {
    "      \     '+': 'win32yank.exe -o',
    "      \     '*': 'win32yank.exe -o',
    "      \   },
    "      \ }
    " You can also check for environment variables like $WSL_DISTRO_NAME
    if $WSL_DISTRO_NAME != ""
        " Put settings specific to a named distro here
    endif

    " Inform the user where they are
    echo "Running in WSL environment"
elseif has('linux')
    " Standard Linux configurations
    " These settings apply to a typical Linux system (e.g., a remote server or VM)
    echo "Running in standard Linux environment"
else
    " Other systems (like native Windows Vim or macOS)
    echo "Running in a non-WSL/Linux environment"
endif

