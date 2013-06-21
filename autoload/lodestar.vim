let lodestar#sep = '/'
let lodestar#lodes_path = '~/.vim/lodes'
let lodestar#manifest = 'manifest.json'

" FUNCTION: filter(pattern, dict) {{{1
" Takes in a dictionary and returns all key value
" pairs that have keys starting with the passed pattern
function! lodestar#filter(pattern, dict)
    let tmp = {}

    for [key, value] in items(a:dict)
        if key =~# '^' . a:pattern
            let tmp[key] = value
        endif
    endfor

    return tmp
endfunction
