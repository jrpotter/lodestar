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
        return s:_MoveCursorUp(a:menu)
    elseif a:key == 'j'
        return s:_MoveCursorDown(a:menu)
    elseif a:key == "\<CR>"
        return s:_ToggleNodeFold(a:menu)
    elseif a:key == 'q'
        return s:_Close()
    endif
endfunction

" FUNCTION: _MoveCursorUp(menu) {{{1
" Moves cursor down menu. If current node
" is unfolded, move selection down a level
function! s:_MoveCursorUp(menu)
    let active = a:menu.active
    let selection = active.selection
    let highlighted = active.links[selection]

    if selection > 0
        let active.selection = selection - 1
    else
        let a:menu.active = active.parent
    endif

    if line('.') - 1 > a:menu.topmost
        call cursor(line('.') - 1, 1)
    endif
endfunction

" FUNCTION: _MoveCursorDown(menu) {{{1
" Moves cursor down menu. If current node
" is unfolded, move selection down a level
function! s:_MoveCursorDown(menu)
    let active = a:menu.active
    let selection = active.selection
    let highlighted = active.links[selection]

    " Traverse down a level
    if highlighted.unfolded
        let a:menu.active = highlighted

    " Traverse up/through levels
    else
        while selection == active.size - 1
            let active = active.parent
            let selection = active.selection
            if active is a:menu | break | endif
        endwhile    

        " Possibly back to menu
        if selection < active.size - 1
            let active.selection = selection + 1
        endif
    endif

    call cursor(line('.') + 1, 1)
endfunction

" FUNCTION: _ToggleNodeFold(menu) {{{1
" Opens and closes node (hide and show all
" sublinks)
function! s:_ToggleNodeFold(menu)
    let active = a:menu.active
    let selection = active.selection
    let highlighted = active.links[selection]

    let line = line('.')
    if !highlighted.unfolded
        let highlighted.unfolded = 1
        call highlighted.Unfold()

        for link in highlighted.links
            call append(line, ' ' . link.title)
            let line = line + 1
        endfor
    else
        call cursor(line + 1, 1)
        let highlighted.unfolded = 0
        for link in highlighted.links
            normal! dd
        endfor
        call cursor(line, 1)
    endfor
endfunction

" FUNCTION: _Close() {{{1
" Exit window
function! s:_Close()
    exe "normal! :q\<CR>"
    return 1
endfunction
