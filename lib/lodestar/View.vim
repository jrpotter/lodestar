" ==============================================================
" File:         View.vim
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
" Description:  Shows the contents of the hierarchical model
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_LodestarView') | finish | endif

let s:View = copy(g:LodestarNode)
let g:LodestarView = s:View


" FUNCTION: new(title) {{{1 Constructor
" Expects name of the scratch buffer created
" ==============================================================
function! s:View.new(title)
    let View = copy(self)

    " Node related members
    let View.pos = 0
    let View.links = []
    let View.parent = {}

    let View.title = a:title
    let View.path = g:lodestar#lodes_path
    let View.isdir = isdirectory(View.path)

    let View.depth = -1
    let View.opened = 0
    let View.unfolded = 0

    " Initialize self/display
    call View.create()
    call View.toggle()
    call View.drawHeader()
    call View.drawBody()

    return View
endfunction 


" FUNCTION: create() {{{1 Builds new window
" ==============================================================
function s:View.create()
    exe "30vne " . self.title
    setlocal cursorline
    setlocal winfixwidth
    setlocal noswapfile
    setlocal buftype=nofile

    syn match LodestarDepth "[|]"
    syn match LodestarOperator "[-+~#]"
    hi LodestarDepth ctermfg=DarkBlue
    hi LodestarOperator ctermfg=DarkRed
    hi LodestarHeader ctermfg=LightGray
    hi CursorLine term=bold ctermfg=Green
endfunction


" FUNCTION: drawHeader() {{{1 Write header to top of buffer
" ==============================================================
function s:View.drawHeader()
    let header = [
        \ '------Lodestar Menu------',
        \ "   Press '?' for help    ",
        \ '=========================']

    let i = 0
    for line in header
        call append(i, line)
        let i = i + 1

        exe 'syn match LodestarHeader /' . line . '/'
    endfor

    let self.limit = i + 1
endfunction


" FUNCTION: drawBody() {{{1 Write links from header down
" ==============================================================
function s:View.drawBody()
    let i = self.limit
    for link in self.links
        call append(i, link.screenName())
        let i = i + 1
    endfor

    call cursor(self.limit + 1, 1)
endfunction
