" ==============================================================
" File:         node.vim
" Description:  Controls input when in a menu
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_LodestarKeymap') | finish | endif


" VARIABLE: active {{{1 Keeps track of highlighted node
" ==============================================================
let s:active = {}


" VARIABLE: LodestarBufferMap {{{1 Pairs buffers to menus
" ==============================================================
let g:LodestarBufferMap = {}


" VARIABLE: LodestarBufferCount {{{1 Appended to buffer names
" ==============================================================
let g:LodestarBufferCount = 0


" FUNCTION: LodestarKeyMap() {{{1 Reads in key and delegates out
" ==============================================================
function g:LodestarKeyMap()
    let exiting = 0
    let name = bufname('%')
    let s:active = g:LodestarBufferMap[name]

    while !exiting
        try
            redraw!
            let key = nr2char(getchar())
            let exiting = s:__MapInputKey(key)
        catch | endtry
    endwhile
endfunction


" FUNCTION: __MapInputKey(key) {{{1 Calls appropriate function
" ==============================================================
function s:__MapInputKey(key)
    if     a:key == 'k'      | return s:__MoveCursorUp()
    elseif a:key == 'j'      | return s:__MoveCursorDown()
    elseif a:key == "\<CR>"  | return s:__ToggleFold()
    elseif a:key == 'q'      | return s:__CloseWindow()
    endif
endfunction


" FUNCTION: __MoveCursorUp() {{{1 Set cursor up one position
" Three possible situations are available:
"
"   1. Hitting unfolded node {{{2
"   If a node is unfolded, this implies and inner node is
"   available between the the active and hit nodes' lines.
"   Must move into hit node and move to bottommost node.
"
"   2. Hitting active head. {{{2
"   In this case, must set active to parent.
"
"   3. Nothing {{{2
"   In this case, just move cursor up
"
" ==============================================================
function s:__MoveCursorUp() 
    " Case 3
    if s:active.pos > 0
        let s:active.pos = s:active.pos - 1 
        let current = s:active.Selected()

        " Case 1
        while current.unfolded
            let s:active = current
            let current = current.links[-1]
        endwhile

        call cursor(line('.') - 1, 1)

    " Case 2
    elseif !empty(s:active.parent)
        let s:active = s:active.parent
        call cursor(line('.') - 1, 1)
    endif
endfunction


" FUNCTION: __MoveCursorDown() {{{1 Set cursor down one position
" Has three situations that parallel __MoveCursorUp()
" ==============================================================
function s:__MoveCursorDown()
    " Case 1
    if s:active.Selected().unfolded
        let s:active = s:active.Selected()
        call cursor(line('.') + 1, 1)

    " Case 3
    elseif line('.') < line('$')

        " Case 1
        while s:active.pos == len(s:active.links) - 1
            let s:active = s:active.parent
        endwhile

        let s:active.pos = s:active.pos + 1
        call cursor(line('.') + 1, 1)
    endif
endfunction

" FUNCTION: __ShowDirectory(node, line) {{{1 Display contents
" ==============================================================
function s:__ShowDirectory(node, line)
    if a:node.unfolded
        let line = a:line
        for link in a:node.links
            call append(line, link.Title())
            call s:__ShowDirectory(link, line + 1)
            let line = line + link.Coverage()
        endfor
    endif
endfunction


" FUNCTION: __ToggleFold() {{{1 Opens/Closes selected node
" ==============================================================
function s:__ToggleFold()
    let line = line('.')
    let current = s:active.Selected()

    call current.Toggle()
    call setline(line, current.Title())

    if isdirectory(current.path)
        if current.unfolded
            call s:__ShowDirectory(current, line)
        else
            let clean = current.Hidden()
            exe line + 1 . "d _ " . clean
            call cursor(line, 1)
        endif
    else
        " Open file
    endif
endfunction


" FUNCTION: __CloseWindow() {{{1 Exit Menu
" ==============================================================
function s:__CloseWindow()
    exe 'q'
    return 1
endfunction
