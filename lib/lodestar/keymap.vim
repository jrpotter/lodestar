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
        catch /^Vim:Interrupt$/ | endtry
    endwhile

    let g:LodestarBufferMap[name] = s:active
endfunction


" FUNCTION: __MapInputKey(key) {{{1 Calls appropriate function
" ==============================================================
function s:__MapInputKey(key)
    if     a:key == 'k'      | return s:__MoveCursorUp()
    elseif a:key == 'j'      | return s:__MoveCursorDown()
    elseif a:key == "\<CR>"  | return s:__ToggleFold()
    elseif a:key == 'o'      | return s:__ToggleFold()
    elseif a:key == 'h'      | return s:__HSplitWindow()
    elseif a:key == 'v'      | return s:__VSplitWindow()
    elseif a:key == 'l'      | return s:__LeaveWindow()
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
    if line('.') < line('$')
        " Case 1
        if s:active.Selected().unfolded
            let s:active = s:active.Selected()
            call cursor(line('.') + 1, 1)

        " Case 3
        else

            " Case 1
            while s:active.pos == len(s:active.links) - 1
                let s:active = s:active.parent
            endwhile

            let s:active.pos = s:active.pos + 1
            call cursor(line('.') + 1, 1)
        endif
    endif
endfunction

" FUNCTION: __ShowDirectory(node, line) {{{1 Display contents
" ==============================================================
function s:__ShowDirectory(node, line)
    if a:node.unfolded
        let line = a:line
        for link in a:node.links
            call append(line, link.Display())
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
    call setline(line, current.Display())

    if current.isdir
        if current.unfolded
            call s:__ShowDirectory(current, line)
        else
            let clean = 0
            for link in current.links
                if empty(link) | continue | endif
                let clean = clean + link.Coverage() 
            endfor

            if clean > 0
                exe line + 1 . "d _ " . clean
                call cursor(line, 1)
            endif
        endif
    else
        return s:__OpenFile()
    endif
endfunction


" FUNCTION: __InitWindow(path) {{{1 Initialize new window
" ==============================================================
function s:__InitWindow(command) 
    let path = s:active.Selected().path

    exe a:command . " " . path
    filetype detect
    setlocal ro

    return 1
endfunction


" FUNCTION: __OpenFile() {{{1 Opens file
" ==============================================================
function s:__OpenFile()
    let window = winnr('#')
    let modified = getwinvar(window, '&mod')

    if modified
        echo "Unsaved changes to current buffer"
        call getchar()
    else 
        exe window . 'wincmd w'
        call s:__InitWindow("edit")
    endif

    return !modified
endfunction


" FUNCTION: __HSplitWindow() {{{1 Open lode horizontally
" ==============================================================
function s:__HSplitWindow()
    exe winnr('#') . 'wincmd w'
    return s:__InitWindow('rightbelow new')
endfunction


" FUNCTION: __VSplitWindow() {{{1 Open lode vertically
" ==============================================================
function s:__VSplitWindow()
    exe winnr('#') . 'wincmd w'
    return s:__InitWindow("vne")
endfunction


" FUNCTION: __LeaveWindow() {{{1 Return to previous window
" ==============================================================
function s:__LeaveWindow()
    exe winnr('#') . "wincmd w"
    return 1
endfunction


" FUNCTION: __CloseWindow() {{{1 Exit Menu
" ==============================================================
function s:__CloseWindow()
    exe 'q'
    return 1
endfunction
