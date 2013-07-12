" ==============================================================
" File:         lodestar.vim
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
" Description:  Vim plugin for quick lookup of compsci topics
"
" ==============================================================

if lodestar#guard('g:loaded_Lodestar') | finish | endif
if !has('python') | echo 'Compile with +python' | finish | endif

" Global vim files
runtime lib/lodestar/Python.vim
runtime lib/lodestar/Keymap.vim

" Nodes
runtime lib/lodestar/Node.vim
runtime lib/lodestar/Wiki.vim
runtime lib/lodestar/View.vim


" Custom map {{{1 Map <Plug>LodestarMain in .vimrc
" ==============================================================
if !hasmapto('<Plug>LodestarMain')
    map <unique> <F2> <Plug>LodestarMain
endif
noremap <unique> <script> <Plug>LodestarMain <SID>Main
noremap <unique> <script> <SID>Main    :call <SID>Main()<CR>


" FUNCTION: Main() {{{1 Program called here
" ==============================================================
function s:Main()
    " Unique buffer name
    let title = 'LodestarMenu_' . g:LodestarBufferCount
    let lodestar = g:LodestarView.new(title)

    " Pair name to object in global map
    let g:LodestarBufferMap[title] = lodestar
    let g:LodestarBufferCount = g:LodestarBufferCount + 1

    " Make sure first & subsequent calls run KeyMap
    exe "au BufEnter " . title . " :call g:LodestarKeyMap()"
    call g:LodestarKeyMap()
endfunction
