" ==============================================================
" File:         view.vim
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
" Description:  Viewport of lode hierarchy. This class also
"               serves as the parentmost node. 
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_LodestarView') | finish | endif

" Keep static members of g:LodestarNode
let s:view = copy(g:LodestarNode)
let g:LodestarView = s:view


" FUNCTION: New(title) {{{1 Constructor
" Expects name of the scratch buffer created
" ==============================================================
function! s:view.New(title)
    let view = copy(self)

    " Required node values
    let view.pos = 0
    let view.isdir = 1
    let view.limit = 0
    let view.depth = -1
    let view.links = []
    let view.path = g:lodestar#lodes_path

    " Setup Window
    exe "30vne " . a:title
    setlocal cursorline
    setlocal winfixwidth
    setlocal noswapfile
    setlocal buftype=nofile

    " Set highlighting of characters
    syn match LodestarDepth "[|]"
    syn match LodestarOperator "[-+~]"
    hi LodestarDepth ctermfg=DarkBlue
    hi LodestarOperator ctermfg=DarkRed
    hi LodestarHeader ctermfg=LightGray
    hi CursorLine term=bold ctermfg=Green

    " Draw screen
    call view.Open()
    call view.DrawHeader()
    call view.DrawLinks()

    return view
endfunction


" FUNCTION: DrawHeader() {{{1 Write header to top of buffer
" ==============================================================
function s:view.DrawHeader()
    let header = [
        \ '------Lodestar Menu------',
        \ '=========================']

    let i = 0
    for line in header
        call append(i, line)
        let i = i + 1

        exe 'syn match LodestarHeader /' . line . '/'
    endfor

    let self.limit = i + 1
endfunction


" FUNCTION: DrawLinks() {{{1 Write links from header down
" ==============================================================
function s:view.DrawLinks()
    let i = self.limit
    for link in self.links
        call append(i, link.Display())
        let i = i + 1
    endfor

    call cursor(self.limit + 1, 1)
endfunction
