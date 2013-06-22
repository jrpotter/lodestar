" Parent of all other nodes. Represents the
" actual viewport of the hierarchy of nodes.
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
function! s:ls_menu.New()
    let ls_menu = copy(self)
    let ls_menu.topmost = 0

    call ls_menu.Init()
    call ls_menu.Unfold()
    call ls_menu.DrawHeader()
    call ls_menu.DrawLinks()

    " Regulates interaction with menu
    let g:LodestarBufferMap[ls_menu.title] = ls_menu
    exe "au BufEnter " . ls_menu.title . " :call g:LodestarKeyMap()"
    call g:LodestarKeyMap()

    return ls_menu
endfunction

" FUNCTION: Initializer {{{1
" Set up window/buffer options.
function! s:ls_menu.Init()
    " Unique name
    let self.title = 'LodestarMenu_' . g:LodestarBufferCount
    let g:LodestarBufferCount = g:LodestarBufferCount + 1

    " Aesthetics
    exe "30vne " . self.title
    setlocal cursorline
    setlocal winfixwidth
    hi CursorLine term=bold ctermfg=Cyan

    " No saving file
    setlocal noswapfile
    setlocal buftype=nofile
endfunction

" FUNCTION: Unfold {{{1
" Returns all links of node
function! s:ls_menu.Unfold()
    let dirs = g:lodestar#lodes_path . '/*'
    for path in glob(dirs, 0, 1)
        if isdirectory(path)
            let tmp = g:LodestarLode.New(path)
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
        call append(i, link.title)
        let i = i + 1
    endfor

    " Moves cursor to first link
    call cursor(self.topmost + 1, 1)
endfunction

