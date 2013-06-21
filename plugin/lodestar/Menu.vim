" Determines correct node to open by determining
" the nodes depth and climbing the tree until it
" hits a parent, building the path as it goes
if exists('g:loaded_LodestarMenu')
    finish
endif | let g:loaded_LodestarMenu = 1

runtime! plugin/lodestar/Node.vim
let s:ls_menu = g:LodestarNode.New()
let g:LodestarMenu = s:ls_menu

" FUNCTION: Constructor {{{1
function! s:ls_menu.New()
    let ls_menu = copy(self)
    let ls_menu.upper_bound = 0

    call ls_menu.Init()
    call ls_menu.KeyMap()

    return ls_menu
endfunction

" FUNCTION: Initializer {{{1
" Set up window/buffer options.
function! s:ls_menu.Init()
    30vne LodestarMenu
    setlocal cursorline
    setlocal winfixwidth
    hi CursorLine term=bold ctermfg=Cyan

    call ls_menu.Unfold()
    call ls_menu.DrawHeader()
    call ls_menu.DrawLinks()
endfunction

" FUNCTION: Unfold {{{1
" Returns all links of node
function! s:ls_menu.Unfold()
    let dirs = g:lodestar#lodes_path . '/*'
    for path in glob(dirs, 0, 1)
        if isdirectory(path)
            let tmp = g:LodestarLode.New(path)
            if !empty(tmp.title)
                let self.links[tmp.title] = tmp
            endif
        endif
    endfor
endfunction

" FUNCTION: DrawHeader {{{1
" Writes the specified header to the current buffer.
function! s:ls_menu.DrawHeader()
    let header = [
        \ '-----Lodestar Menu-----',
        \ '=======================']

    let i = 0
    for line in header
        call append(i, line)
        let i = i + 1
    endfor

    " Ensures user won't enter header
    let self.upper_bound = i + 1
endfunction

" FUNCTION: DrawLinks {{{1
" Writes all available links starting at the menus
" upper bound
function! s:ls_menu.DrawLinks()
    let i = self.upper_bound
    let ordered = sort(keys(self.links)) 
    for link in ordered
        call append(i, link)        
        let i = i + 1
    endfor

    " Moves cursor to first link
    if !empty(ordered)
        call setpos('.', [0, self.upper_bound + 1, 0, 0])
    endif
endfunction

" FUNCTION: KeyMap {{{1
" Controls how input is handled in the window.
function! s:ls_menu.KeyMap()
    let invalid = 0
    while !invalid
        try 
            redraw!
            let key = nr2char(getchar())
            let invalid = self._MapInputKey(key)
        catch | endtry
    endwhile
endfunction

" FUNCTION: _MapInputKey(key) {{{1
" Pairs characters to their corresponding functions
function! s:ls_menu._MapInputKey(key)
    if a:key == 'k'
        call self._MoveCursorUp()
    elseif a:key == 'j'
        call self._MoveCursorDown()
    elseif a:key == 'l'
        call self._ExitWindow()
        return 1
    elseif a:key == 'q'
        call self._CloseWindow()
        return 1
    endif
endfunction

" FUNCTION: _MoveCursorUp() {{{1
" Moves cursor up unless reaching upper bound
function! s:ls_menu._MoveCursorUp()
    let cur = line('.')
    if cur - 1 > self.upper_bound
        call cursor(cur - 1, 1)
    endif 
endfunction

" FUNCTION: _MoveCursorDown() {{{1
function! s:ls_menu._MoveCursorDown()
    let cur = line('.')
    call cursor(cur + 1, 1)
endfunction

" FUNCTION: _OpenNode() {{{1
function! s:ls_menu._OpenNode()
    
endfunction

" FUNCTION: _ExitWindow() {{{1
function! s:ls_menu._ExitWindow()
    exe "normal! \<c-w>l"
endfunction

" FUNCTION: _CloseWindow() {{{1
function! s:ls_menu._CloseWindow()
    exe "normal! :q!\<CR>"
endfunction
