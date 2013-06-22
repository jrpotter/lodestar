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

" FUNCTION: swap(list, fst, snd) {{{1
" Swaps two items in a list
function! lodestar#swap(list, fst, snd)
    let tmp = a:list[a:fst]
    let a:list[a:fst] = a:list[a:snd]
    let a:list[a:snd] = tmp
endfunction

" FUNCTION: _partition(list, left, right) {{{1
" Subroutine used by quicksort for managing sorting
" each recursive half
function! lodestar#_partition(list, left, right)
    let pivot = (a:left + a:right) / 2
    let pivot_value = a:list[pivot]

    " Set pivot as first element in sublist
    call lodestar#swap(a:list, a:right, pivot)

    " Set all smaller values before pivot
    let less = 0
    for i in range(a:left, a:right-1)
        if a:list[i].Compare(pivot_value) <= 0
            call lodestar#swap(a:list, i, less)
            let less = less + 1
        endif
    endfor

    " Return pivot
    call lodestar#swap(a:list, a:right, less)
    return less
endfunction

" FUNCTION: quicksort(list) {{{1
" To use, make sure object passed has a Compare method
" return 0 if equal, -1 if less than, and 1 if greater.
function! lodestar#quicksort(list, ...)
    if a:0
        let left = a:1
        let right = a:2
    else
        let left = 0
        let right = len(a:list) - 1
    endif

    if l:left < l:right
        let mid = lodestar#_partition(a:list, left, right)

        call lodestar#quicksort(a:list, left, mid - 1)
        call lodestar#quicksort(a:list, mid + 1, right)
    endif
endfunction
