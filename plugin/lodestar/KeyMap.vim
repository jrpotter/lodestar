" Controls how keys are handled inside a LodestarMenu.
" 
" Maintainer: Joshua Potter
" Contact: jrpotter@live.unc.edu
if exists('g:loaded_LodestarKeyMap')
    finish
endif | let g:loaded_LodestarKeyMap = 1

" VARIABLE: LodestarBufferMap {{{1
" Maps buffer names to actual menu for
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
    let menu = g:LodestarBufferMap[name]

    while !invalid
        try
            redraw!
            let key = nr2char(getchar())
            let invalid = s:_MapInputKey(key, menu)
        catch | endtry
    endwhile
endfunction

" FUNCTION: _MapInputKey(key, menu) {{{1
" Controls how input works depending on the
" menu currently in
function! s:_MapInputKey(key, menu)
    if a:key == 'k'
        return s:_MoveCursorUp(menu)
    elseif a:key == 'j'
        return s:_MoveCursorDown(menu)
    elseif a:key == '\n'
        return s:_ToggleNodeFold(menu)
    elseif a:key == 'q'
        return s:_Close()
    endif
endfunction

" FUNCTION: _MoveCursorUp(menu) {{{1
" Moves cursor down menu. If current node
" is unfolded, move selection down a level
function! s:_MoveCursorUp(menu)

endfunction

" FUNCTION: _MoveCursorDown(menu) {{{1
" Moves cursor down menu. If current node
" is unfolded, move selection down a level
function! s:_MoveCursorDown(menu)

endfunction

" FUNCTION: _ToggleNodeFold(menu) {{{1
" Opens and closes node (hide and show all
" sublinks)
function! s:_ToggleNodeFold(menu)

endfunction

" FUNCTION: _Close() {{{1
" Exit window
function! s:_Close()
    exe "normal! :q\<CR>"
    return 1
endfunction
