let g:highlight = 0

function personal#Highlight()
    if g:highlight
        let g:highlight = 0
        match none
    else
        let g:highlight = 1
        exec 'match' 'Search' '/\<' . expand("<cword>") . '\>/'
    endif
endfunction


function personal#Replace()
    let @0 = @"
    normal! gvd
    normal! "0P
endfunction


function personal#CppSwitch()
    " XXX scope variables as local with l: prefix
    let filename = @%
    let len = strlen(filename)

    if strpart(filename, len - 2) == ".h"
        let pairname = strpart(filename, 0, len - 2) . ".cpp"
        execute 'edit' pairname
    elseif strpart(filename, len - 4) == ".cpp"
        let pairname = strpart(filename, 0, len - 4) . ".h"
        execute 'edit' pairname
    else
        echo "Not C++ file" filename
        echo "Cannot switch header / source"
    endif
endfunction


function personal#NameNoName()
    let filename = @%

    if filename != ''
        echo 'error: current buffer has a name'
        finish
    endif

    let current = 0

    while 1
        let suggest = expand('~/.vim/noname/' . current)

        if filereadable(suggest)
            let current = current + 1
        else
            break
        endif
    endwhile

    execute 'write' suggest
endfunction