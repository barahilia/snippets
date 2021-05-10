let filename = @%

if filename != ''
    echo 'error: current buffer has a name'
    finish
endif

let used_names = split(globpath('~/.vim/noname', '*'))
let current = 0

while current <= len(used_names)
    let suggest = expand('~/.vim/noname/' . current)

    if current == len(used_names)
        break
    endif

    if suggest != used_names[current]
        break
    endif

    let current = current + 1
endwhile

execute 'write' suggest
