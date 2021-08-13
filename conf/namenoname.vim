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
