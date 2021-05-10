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
