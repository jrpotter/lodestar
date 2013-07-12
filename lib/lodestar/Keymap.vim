" ==============================================================
" File:         Keymap.vim
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
" Description:  Controls all input when in a menu
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


" FUNCTION: LodestarClose() {{{1 Close window if last
" ==============================================================
function g:LodestarClose()
    if winnr() == winnr('$')
        call s:__CloseWindow()
    endif
endfunction


" FUNCTION: LodestarKeyMap() {{{1 Reads in key and calls the
" appropriate function
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
    elseif a:key == 'r'      | return s:__RefreshFold()
    elseif a:key == 'h'      | return s:__HSplitWindow()
    elseif a:key == 'v'      | return s:__VSplitWindow()
    elseif a:key == 'w'      | return s:__SearchWiki()
    elseif a:key == 'l'      | return s:__LeaveWindow()
    elseif a:key == 'q'      | return s:__CloseWindow()
    elseif a:key == '?'      | return s:__DisplayHelp()
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
        let current = s:active.active()

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

    " Show the header again
    else
        let current = line('.')
        normal! gg
        call cursor(current, 1)
    endif
endfunction


" FUNCTION: __MoveCursorDown() {{{1 Set cursor down one position
" Has three situations that parallel __MoveCursorUp()
" ==============================================================
function s:__MoveCursorDown()
    if line('.') < line('$')
        " Case 1
        if s:active.active().unfolded
            let s:active = s:active.active()
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
            call append(line, link.screenName())
            call s:__ShowDirectory(link, line + 1)
            let line = line + link.coverage()
        endfor
    endif
endfunction


" FUNCTION: __CleanDirectory(node, line) {{{1 Removes lines
" ==============================================================
function s:__CleanDirectory(node, line)
    let clean = 0
    for link in a:node.links
        let clean = clean + link.coverage() 
    endfor

    " Fails when deleting 0
    if clean > 0
        exe a:line + 1 . "d _ " . clean
        call cursor(a:line, 1)
    endif
endfunction


" FUNCTION: __RefreshFold() {{{1 Repopulate the node
" ==============================================================
function s:__RefreshFold()
    let current = s:active.active()

    if current.unfolded
        call s:__ToggleFold()
    endif

    " Clear current links
    if !empty(current.links)
        call remove(current.links, 0, len(current.links) - 1)
    endif

    " Rebuild entirely
    call current.parseManifest(current.path)
    call current.open()        
    call setline(line('.'), current.screenName())
endfunction


" FUNCTION: __ToggleFold() {{{1 Opens/Closes selected node
" ==============================================================
function s:__ToggleFold()
    let line = line('.')
    let current = s:active.active()

    call current.toggle()
    call setline(line, current.screenName())

    if current.isdir
        if !current.empty
            if current.unfolded
                call s:__ShowDirectory(current, line)
            else
                call s:__CleanDirectory(current, line)
            endif
        endif
    else
        return s:__OpenFile()
    endif
endfunction


" FUNCTION: __SearchWiki() {{{1 Queries Wikipedia content
" ==============================================================
function s:__SearchWiki()
    let current = s:active.active()

    if getwinvar(winnr('#'), '&mod')
        echo "Unsaved changes to current buffer"
        call getchar()
    else 
        exe winnr('#') . 'wincmd w'
        setlocal tw=80
        setlocal noswapfile
        setlocal buftype=nofile

python << endpython

# Should provide user_agent when using WikiMedia's API
user_agent = vim.eval('g:lodestar#user_agent')

with WikiHandler(user_agent) as wiki:
    # If no page specified, must search again with result
    query = vim.eval('current.wiki')

    if not len(query): 
        query = vim.eval('current.title')
        try:
            content = wiki.get_data(query, search=True)
            query = content['search'][0]
        except IndexError:
            print("Search returned no results")

    content = wiki.get_data(query, True, True)

    # Set up buffer
    del vim.current.buffer[:]
    vim.current.buffer[0] = "Wikipedia: " + str(query)

    # Display content in order
    sections = ['introduction'] + wiki.segment_order
    for section in sections:
        vim.current.buffer.append('')
        vim.current.buffer.append(section)
        vim.current.buffer.append('================')

        content_sections = content[section].split("\n")
        for cs in content_sections: vim.current.buffer.append(cs)

endpython
        " Select all in visual mode and format
        normal! ggVGgqgg
        setlocal ro
        return 1
    endif
endfunction


" FUNCTION: __InitWindow(cmd) {{{1 Initialize new window
" ==============================================================
function s:__InitWindow(cmd) 
    exe a:cmd . " " . s:active.active().path
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


" FUNCTION: __DisplayHelp() {{{1 Exit Menu
" ==============================================================
function s:__DisplayHelp()
    help lodestar
    return 1
endfunction
