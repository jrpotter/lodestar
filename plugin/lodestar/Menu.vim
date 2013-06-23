" Parent of all other nodes. Represents the
" viewport of the node hierarchy. Also used
" for manipulation of all files opened within.
"
" Maintainer: Joshua Potter
" Contact: jrpotter@live.unc.edu
if exists('g:loaded_LodestarMenu')
    finish
endif | let g:loaded_LodestarMenu = 1

" Initialize
let s:ls_menu = g:LodestarNode.New()
let g:LodestarMenu = s:ls_menu

" FUNCTION: New() {{{1
function! s:ls_menu.New(title)
    let menu = copy(self)

    " Allows for easier navigation
    let menu.depth = -1
    let menu.topmost = 0
    let menu.parent = menu
    let menu.title = a:title
    let menu.path = g:lodestar#lodes_path

    " Draw window and set options
    exe "30vne " . menu.title
    setlocal cursorline
    setlocal winfixwidth
    setlocal noswapfile
    setlocal buftype=nofile
    hi CursorLine term=bold ctermfg=Cyan

    " Draw window & screen
    call menu.Unfold()
    call menu.DrawHeader()
    call menu.DrawLinks()

    return menu
endfunction

" FUNCTION: Unfold {{{1
" Overrides node function call. Builds
" lodes instead of nodes for links
function! s:ls_menu.Unfold()
    for path in glob(self.path . '/*', 0, 1)
        if isdirectory(path)
            let tmp = g:LodestarLode.New(path, self)
            call add(self.links, tmp)
        endif
    endfor

    call lodestar#quicksort(self.links)
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
    let self.topmost = i + 1
endfunction

" FUNCTION: DrawLinks {{{1
" Writes all available links starting at the menus
" upper bound
function! s:ls_menu.DrawLinks()
    let i = self.topmost
    for link in self.links
        call append(i, link.Title())
        let i = i + 1
    endfor

    " Moves cursor to first link
    call cursor(self.topmost + 1, 1)
endfunction

