if exists('g:loaded_LodestarNode')
    finish
endif | let g:loaded_LodestarNode = 1

let s:ls_node = {}
let g:LodestarNode = s:ls_node

" FUNCTION: New {{{1
function! s:ls_node.New()
    let node = copy(self)

    let node.path = ''
    let node.title = ''
    let node.links = {}
    let node.names = {}

    let node.leaf = 0
    let node.unfolded = 0

    return node
endfunction

" FUNCTION: Unfold {{{1
" Returns all links of node
function! s:ls_node.Unfold(...)
    if !self.unfolded || a:0 " Refresh
        for path in glob(self.path, 0, 1)
            let tmp = g:LodestarNode.New()
            let pieces = split(path, g:lodestar#sep)

            let tmp.path = path
            let tmp.leaf = !isdirectory(path)

            " A node is either named or defaults to filename
            let tmp.names = lodestar#filter(self.names, path)
            let tmp.title = get(self.names, path, pieces[-1])
            let self.links[tmp.title] = tmp
        endfor

        let self.unfolded = 1
    endif
endfunction
