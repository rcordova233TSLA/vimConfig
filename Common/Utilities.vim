function! Gather(pattern)
    " Gather search hits, and display in a new scratch buffer.
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
command! TrimSpaces call TrimTrailingWhiteSpace()

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
" Will automatically close any buffers that have no active window
au BufEnter * call CloseHiddenBuffers()
command! CloseHiddenBuffers call CloseHiddenBuffers()

command! RemoveDos %s///g
command! RemoveDosAddCr %s//\r/g
