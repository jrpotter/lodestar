" ==============================================================
" File:         lodestar.vim
" Description:  Collection of lodestar 'library' functions
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
"
" ==============================================================


" VARIABLE: lodes_path {{{1 Path of references
" ==============================================================
let lodestar#user_agent = 'jrpotter@live.unc.edu'
let lodestar#lodes_path = expand('<sfile>:p:h') . '/../lodes'
let lodestar#wiki_cache = lodestar#lodes_path . '/.wiki_cache'


" FUNCTION: header_guard(name) {{{1 Ensures only single include
" ==============================================================
function lodestar#guard(name)
    if exists(a:name) | return 1 | endif
    exe "let " . a:name . " = 1"
endfunction


" FUNCTION: cut(path) {{{1 Remove last segment of a path
" ==============================================================
function lodestar#cut(path)
python << endpython

path = vim.eval('a:path')
head, tail = os.path.split(path)
vim.command("return '{}'".format(tail))

endpython
endfunction


" FUNCTION: join(head, tail) {{{1 Join strings
" ==============================================================
function lodestar#join(head, tail)
python << endpython

head = vim.eval('a:head')
tail = vim.eval('a:tail')
path = os.path.join(head, tail)
vim.command("return '{}'".format(path))

endpython
endfunction


" FUNCTION: swap(list, fst, snd) {{{1 Swap items in list
" ==============================================================
function lodestar#swap(list, fst, snd)
    let tmp = a:list[a:fst]
    let a:list[a:fst] = a:list[a:snd]
    let a:list[a:snd] = tmp
endfunction


" FUNCTION: __partition(list, left, right) {{{1
" Private method not to be called by user. Subroutine used for
" sorting quicksort's recursive halves
" ==============================================================
function lodestar#__partition(list, left, right)
    let pivot_index = (a:left + a:right) / 2
    let pivot_value = a:list[pivot_index]

    let lesser = a:left
    call lodestar#swap(a:list, pivot_index, a:right)
    for i in range(a:left, a:right-1)
        if a:list[i].compare(pivot_value) <= 0
            call lodestar#swap(a:list, i, lesser)
            let lesser = lesser + 1
        endif
    endfor
    call lodestar#swap(a:list, a:right, lesser)

    return lesser
endfunction


" FUNCTION: quicksort(list, ...) {{{1 Sorting method
" Recursive sorting method. Requires object type to have a 
" Compare method returning 0 if equal, -1 if <, and 1 if >
" ==============================================================
function lodestar#quicksort(list, ...)
    let left = a:0 ? a:1 : 0
    let right = a:0 ? a:2 : len(a:list) - 1

    if left < right
        let pivot = lodestar#__partition(a:list, left, right)
        call lodestar#quicksort(a:list, left, pivot - 1)
        call lodestar#quicksort(a:list, pivot + 1, right)
    endif
endfunction

