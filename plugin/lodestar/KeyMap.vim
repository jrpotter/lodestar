" Controls how keys are handled inside a LodestarMenu.
" 
" Maintainer: Joshua Potter
" Contact: jrpotter@live.unc.edu
if exists('g:loaded_LodestarKeyMap')
    finish
endif | let g:loaded_LodestarKeyMap = 1

" VARIABLE: active {{{1
" Used to avoid tedious passing of values
let s:active = {}

" VARIABLE: LodestarBufferMap {{{1
" Maps buffer names to LodestarMenu for
" proper traversal
let g:LodestarBufferMap = {}

" VARIABLE: LodestarBufferCount {{{1
" Allows unique names for all buffers
let g:LodestarBufferCount = 0

" FUNCTION: LodestarKeyMap() {{{1
" Controls all key presses and their
" corresponding actions
function! g:LodestarKeyMap()
    let invalid = 0
    let name = bufname('%')
    let s:active = g:LodestarBufferMap[name]

    while !invalid
        try
            redraw!
            let key = nr2char(getchar())
            let invalid = s:_MapInputKey(key)
        catch | endtry
    endwhile
endfunction

" FUNCTION: _MapInputKey(key) {{{1
" Controls how input works depending on the
" menu currently in
function! s:_MapInputKey(key)
    if a:key == 'k'
        return s:_MoveCursorUp()
    elseif a:key == 'j'
        return s:_MoveCursorDown()
    elseif a:key == "\<CR>"
        return s:_ToggleFold(s:active.Current())
    elseif a:key == 'q'
        return s:_Close()
    endif
endfunction

" FUNCTION: _MoveCursorUp() {{{1
" Three possibilites are available when moving up
" a menu. First, and most basic, is a simple traversal
" up a node. Second is hitting the head of a menu. In
" this case simply move up to the parent and continue.
" Lastly hitting a node that is unfolded means needing to
" select the deeper nodes last inner node
function! s:_MoveCursorUp()
    " Traverse
    if s:active.pos > 0
        let s:active.pos = s:active.pos - 1
        let current = s:active.Current()

        while current.unfolded
            let s:active = current
            let current = current.links[-1]
        endwhile
        call cursor(line('.') - 1, 1)

    " Not the main menu
    elseif s:active !is s:active.parent
        let s:active = s:active.parent
        call cursor(line('.') - 1, 1)
    endif
endfunction

" FUNCTION: _MoveCursorDown() {{{1
" Parallels that of _MoveCursorUp()
function! s:_MoveCursorDown()
    "Traverse down level
    if s:active.Current().unfolded
        let s:active = s:active.Current()
        call cursor(line('.') + 1, 1)

    " Traverse down menu
    elseif line('.') < line('$')
        while s:active.pos == s:active.Size() - 1
            let s:active = s:active.parent
        endwhile

        let s:active.pos = s:active.pos + 1
        call cursor(line('.') + 1, 1)
    endif
endfunction

" FUNCTION: _ToggleFold(node, ...) {{{1
" Opens and closes node (hide and show all
" sublinks)
function! s:_ToggleFold(node, ...)

    " Change nodes line
    if !a:0
        let line = line('.')
        call a:node.Unfold()
        call setline(line, a:node.Title())
    else
        let line = a:1
    endif

    " Draw all links
    if a:node.unfolded
        for link in a:node.links
            call append(line, link.Title())
            if link.unfolded
                call s:_ToggleFold(link, line)
                let line = line + link.Size()
            endif
            let line = line + 1
        endfor
    else
        let clean = a:node.Coverage()
        exe line + 1 . "d _ " . clean
        call cursor(line, 1)
    endif
endfunction

" FUNCTION: _Close() {{{1
" Exit window
function! s:_Close()
    exe "normal! :q\<CR>"
    return 1
endfunction
