" The node is the base class for objects present in 
" the main menu that may or may not be opened. 
"
" Maintainer: Joshua Potter
" Contact: jrpotter@live.unc.edu
if exists('g:loaded_LodestarNode')
    finish
endif | let g:loaded_LodestarNode = 1

" Initialize
let s:ls_node = {}
let g:LodestarNode = s:ls_node

" FUNCTION: New(...) {{{1
function! s:ls_node.New(...)
    let node = copy(self)

    " Naming 
    let node.path = ''
    let node.title = ''
    let node.names = {}

    " Positioning relative to other nodes
    let node.links = []
    let node.parent = a:0 ? a:1 : {}

    " Miscellaneous
    let node.pos = 0
    let node.depth = 0
    let node.opened = 0
    let node.unfolded = 0

    return node
endfunction

" FUNCTION: Marker() {{{1
" Tells how node should be prepended in menu.
function! s:ls_node.Marker()
    let cap = repeat('|', self.depth)
    if isdirectory(self.path)
        let marker = self.unfolded ? '-' : '+'
    else
        let marker = '~'
    endif
    return cap . marker
endfunction

" FUNCTION: Title() {{{1
" Convenience function for syntactically-pleasing code
function! s:ls_node.Title()
    return self.Marker() . self.title
endfunction

" FUNCTION: Size() {{{1
" Convenience function for syntactically-pleasing code
function! s:ls_node.Size()
    return len(self.links)
endfunction

" FUNCTION: Selected() {{{1
" Convenience function for syntactically-pleasing code
function! s:ls_node.Selected()
    return self.links[self.pos]
endfunction

" FUNCTION: Compare(node) {{{1
" Used for quicksorting purposes
function! s:ls_node.Compare(node)
    if self.title < a:node.title
        return -1
    elseif self.title == a:node.title
        return 0
    else
        return 1
    endif
endfunction

" FUNCTION: Coverage() {{{1
" Tells how many lines the current node covers
function! s:ls_node.Coverage()
    let lines = 1
    for link in self.links
        let tmp = link.unfolded ? link.Coverage() : 1
        let lines = lines + tmp
    endfor 
    return lines
endfunction

" FUNCTION: _PopulateLinks(names) {{{1
" Private method to get files of a directory
function! s:ls_node._PopulateLinks()
    for path in glob(self.path . '/*', 0, 1)
        let tmp = g:LodestarNode.New(self)

        let tmp.path = path
        let tmp.names = self.names
        let tmp.depth = self.depth + 1
        let tmp.title = get(self.names, path, lodestar#cut(path))

        call add(self.links, tmp)
    endfor
endfunction

" FUNCTION: Unfold {{{1
" Returns all links- if not unfolded previously 
" (or refreshed) will populate menu first
function! s:ls_node.Unfold(...)
    if !self.opened || a:0 " Refresh
        let self.opened = 1

        if isdirectory(self.path)
            call self._PopulateLinks()
            call lodestar#quicksort(self.links)
        endif
    endif

    let self.unfolded = !self.unfolded
endfunction

