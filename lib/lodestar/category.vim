" ==============================================================
" File:         category.vim
" Description:  Further wrapping around lodes
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_LodestarCategory') | finish | endif

let s:category = g:LodestarNode.New()
let g:LodestarCategory = s:category


" FUNCTION: New(node) {{{1 Constructor
" Adopt node and obtain values from it
" ==============================================================
function! s:category.New(node)
    let category = deepcopy(self)
    
    let category.opened = 1
    let category.isdirectory = 1
    let category.names = a:node.names
    let category.title = a:node.category

    return category
endfunction
