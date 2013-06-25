" ==============================================================
" File:         node.vim
" Description:  Base class for foldable objects in menu
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_LodestarNode') | finish | endif

let s:node = {}
let g:LodestarNode = s:node


" FUNCTION: New(...) {{{1 Constructor
" May take in a parent/path for proper traversal upon navigation
" ==============================================================
function s:node.New(...)
    let node = deepcopy(self)

    " Naming/Opening node
    let node.category = ''
    let node.path = a:0 ? a:2 : ''
    let node.names = a:0 ? a:1.names : {}
    let node.title = node.Title()
    let node.isdirectory = isdirectory(node.path)

    " Position relative to other nodes
    let node.pos = 0
    let node.links = []
    let node.ignore = []
    let node.parent = a:0 ? a:1 : {}

    " Keeps state of node
    let node.opened = 0
    let node.unfolded = 0
    let node.depth = a:0 ? a:1.depth + 1 : 0

    return node
endfunction


" FUNCTION: Title() {{{1 Get title or default to filename
" ==============================================================
function s:node.Title()
    return get(self.names, self.path, lodestar#cut(self.path))
endfunction


" FUNCTION: Display() {{{1 Get screen name
" ==============================================================
function s:node.Display()
    let depth = repeat('|', self.depth)
    if !self.isdirectory | let type = '~'
    else | let type = self.unfolded ? '-' : '+' | endif

    return depth . type . self.title
endfunction


" FUNCTION: Selected() {{{1 Currently active subnode
" ==============================================================
function s:node.Selected()
    return self.links[self.pos]
endfunction


" FUNCTION: Compare(node) {{{1 For sorting purposes
" ==============================================================
function s:node.Compare(node)
    if self.title < a:node.title | return -1
    elseif self.title > a:node.title | return 1
    else | return 0 | endif
endfunction


" FUNCTION: Coverage() {{{1 Number of lines covered
" ==============================================================
function s:node.Coverage()
    let total = 1
    if self.unfolded
        for link in self.links
            let sub = link.Coverage()
            let total = total + sub
        endfor 
    endif
    return total
endfunction


" FUNCTION: Hidden() {{{1 Number of lines hidden
" ==============================================================
function s:node.Hidden()
    let total = 0
    for link in self.links
        let sub = link.Coverage()
        let total = total + sub
    endfor 
    return total
endfunction


" FUNCTION: ___PopulateLinks(factory) {{{1 Fills links
" Takes in a constructor for building of nodes
" ==============================================================
function s:node.__PopulateLinks(factory)
    for path in glob(self.path . '/*', 0, 1)
        if index(self.ignore, path) < 0
            let sub = a:factory.New(self, path)
            call add(self.links, sub)
        endif
    endfor

    call lodestar#quicksort(self.links)
endfunction


" FUNCTION: Toggle(...) {{{1 Toggles fold
" If not unfolded previously, populates links. May take in
" another constructor (defaults to g:LodestarNode)
" ==============================================================
function s:node.Toggle(...)
    let factory = a:0 ? a:1 : g:LodestarNode
    if self.isdirectory
        if !self.opened
            let self.opened = 1
            call self.__PopulateLinks(factory)
        endif

        let self.unfolded = !self.unfolded
    endif
endfunction

