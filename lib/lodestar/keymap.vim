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

    " Shallow copy to avoid repetitive variable creation
    let s:active = copy(g:LodestarBufferMap[name])
    let s:active.size = len(s:active.links)
    let s:active.current = s:active.links[s:active.pos]

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
    if a:key == 'k'          | return s:__MoveCursorUp()
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
    
endfunction


" FUNCTION: __MoveCursorDown() {{{1 Set cursor down one position
" Has three situations that parallel __MoveCursorUp()
" ==============================================================
function s:__MoveCursorDown()

endfunction


" FUNCTION: __ToggleFold() {{{1 Opens/Closes selected node
" ==============================================================
function s:__ToggleFold()

endfunction


" FUNCTION: __CloseWindow() {{{1 Exit Menu
" ==============================================================
function s:__CloseWindow()
    exe ":q\<CR>"
    return 1
endfunction
