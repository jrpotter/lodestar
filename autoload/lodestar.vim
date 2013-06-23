" Autoload file for library-like functions
" 
" Maintainer: Joshua Potter
" Contact: jrpotter@live.unc.edu

" VARIABLE: lodes_path {{{1
" Path of all references (coined 'lodes')
let lodestar#lodes_path = '/home/jrpotter/.vim/lodes'

" FUNCTION: cut(path) {{{1
" Removes last piece of a path
function! lodestar#cut(path)
    let piece = strridx(a:path, '/')
    return strpart(a:path, piece+1)
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
" each recursive half. Should not be called by user
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
    " Extra parameters provided by function itself
    if a:0 | let left = a:1 | let right = a:2
    else | let left = 0 | let right = len(a:list) - 1
    endif

    " If list has more than 1 value
    if left < right
        let mid = lodestar#_partition(a:list, left, right)
        call lodestar#quicksort(a:list, left, mid - 1)
        call lodestar#quicksort(a:list, mid + 1, right)
    endif
endfunction
