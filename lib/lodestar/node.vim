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

" Static members
let g:LodestarNode.names = {}
let g:LodestarNode.ignores = {}


" FUNCTION: New(path, parent) {{{1 Constructor
" ==============================================================
function s:node.New(path, parent)
    let node = copy(self)

    " Position relative to other nodes
    let node.pos = 0
    let node.links = []
    let node.parent = a:parent

    " Naming/Opening node
    let node.path = a:path
    let node.isdir = isdirectory(node.path)
    call node.ParseManifest()
    let node.title = get(self.names, a:path, lodestar#cut(a:path))

    " Keeps state of node
    let node.opened = 0
    let node.unfolded = 0
    let node.depth = a:parent.depth + 1

    return node
endfunction


" FUNCTION: Display() {{{1 Get screen name
" ==============================================================
function s:node.Display()
    let depth = repeat('|', self.depth)
    if !self.isdir | let type = '~'
    else | let type = self.unfolded ? '-' : '+' | endif

    return depth . type . self.title
endfunction


" FUNCTION: Selected() {{{1 Currently active subnode
" ==============================================================
function s:node.Selected()
    return empty(self.links) ? {} : self.links[self.pos]
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


" FUNCTION: ParseManifest() {{{1 
" If a manifest file is present in the current directory, it
" is attempted to be parsed, and the corresponding values
" assigned in the vim environment
" ==============================================================
function s:node.ParseManifest()
python << endpython

path = vim.eval('self.path')
man_path = abs_path(path, 'manifest.json')

names = {}
ignores = {}

try:
    with open(man_path, 'r') as man_fp:
        manifest = json.load(man_fp, object_hook = decode)

        # The title replaces the default directory name
        if manifest.has_key('Title'): names[path] = manifest['Title']

        # Ignore manifest file by default
        ignores[man_path] = 1        
        ignores.update({ k : 1 for k in manifest.get('Ignore', [])})

        # Pair paths to new names
        for name, addr in manifest.get('Links', {}).iteritems():
            names[abs_path(path, addr)] = name

        # Assign in Vim
        vim.command('call extend(self.names, {})'.format(names))
        vim.command('call extend(self.ignores, {})'.format(ignores))

except IOError:
    pass

endpython
endfunction


" FUNCTION: Open() {{{1 Used to prevent unnecessary loading
" Called when something is opened for the first time- not
" called again afterward
" ==============================================================
function s:node.Open()
    let self.opened = 1
    for path in glob(lodestar#join(self.path, '*'), 0, 1)
        if !has_key(self.ignores, path)
            let sub = g:LodestarNode.New(path, self)
            call add(self.links, sub)
        endif
    endfor

    call lodestar#quicksort(self.links)
endfunction


" FUNCTION: Toggle() {{{1 Show folded or unfolded
" ==============================================================
function s:node.Toggle()
    if self.isdir
        if !self.opened | call self.Open() | endif
        let self.unfolded = !self.unfolded
    endif
endfunction

