" ==============================================================
" File:         menu.vim
" Description:  Viewport of lode hierarchy
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_LodestarMenu') | finish | endif

let s:menu = g:LodestarNode.New()
let g:LodestarMenu = s:menu


" FUNCTION: New(title) {{{1 Constructor
" Expects unique buffer name to avoid inconsistencies
" ==============================================================
function! s:menu.New(title)
    let menu = deepcopy(self)
    call append(0, len(menu.links))

    let menu.limit = 0
    let menu.title = a:title
    let menu.path = g:lodestar#lodes_path

    " Setup Window
    exe "30vne " . menu.title
    setlocal cursorline
    setlocal winfixwidth
    setlocal noswapfile
    setlocal buftype=nofile
    hi CursorLine term=bold ctermfg=Cyan

    " Draw screen
    call menu.PopulateLinks(g:LodestarLode)
    call menu.DrawHeader()
    call menu.DrawLinks()

    return menu
endfunction


" FUNCTION: DrawHeader() {{{1 Write header to top of buffer
" ==============================================================
function s:menu.DrawHeader()
    let header = [
        \ '-----Lodestar Menu-----',
        \ '=======================']

    let i = 0
    for line in header
        call append(i, line)
        let i = i + 1
    endfor

    let self.limit = i + 1
endfunction


" FUNCTION: DrawLinks() {{{1 Write links from header down
" ==============================================================
function s:menu.DrawLinks()
    let i = self.limit
    for link in self.links
        call append(i, link.Title())
        let i = i + 1
    endfor

    call cursor(self.limit + 1, 1)
endfunction
