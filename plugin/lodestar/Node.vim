" The node is the base class for objects present in 
" the main menu that may or may not be unfoldable. 
"
" Maintainer: Joshua Potter
" Contact: jrpotter@live.unc.edu
if exists('g:loaded_LodestarNode')
    finish
endif | let g:loaded_LodestarNode = 1

" Initialize
let s:ls_node = {}
let g:LodestarNode = s:ls_node

" FUNCTION: New() {{{1
function! s:ls_node.New()
    let node = copy(self)

    " Naming 
    let node.path = ''
    let node.title = ''
    let node.names = {}

    " Organizing subnodes
    let node.links = []
    let node.opened = 0

    " Navigation
    let node.head = 0
    let node.tail = 0
    let node.unfolded = 0

    return node
endfunction

" FUNCTION: _Populate(names) {{{1
" Private method to get files of a directory
function! s:ls_node._Populate()
    for path in glob(self.path . '/*', 0, 1)
        let tmp = g:LodestarNode.New()
        let tmp.path = path

        " Set up user defined title if possible
        if has_key(self.names, path)
            let tmp.title = get(self.names, path)
        else
            let piece = strridx(path, '/')
            if piece < 0 | let piece = 0 | endif
            let tmp.title = strpart(path, piece+1)
        endif

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
            call self._Populate()
            call lodestar#quicksort(self.links)
        endif
    endif

    return self.links
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
