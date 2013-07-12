" ==============================================================
" File:         Node.vim
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
" Description:  Base class for foldable objects in menu
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_LodestarNode') | finish | endif

let s:Node = {}
let g:LodestarNode = s:Node

" Static members
let g:LodestarNode.names = {}
let g:LodestarNode.ignore = {}


" FUNCTION: new(path, parent) {{{1 Constructor
" ==============================================================
function s:Node.new(path, parent)
    let Node = copy(self)

    " Position relative to other nodes
    let Node.pos = 0
    let Node.links = []
    let Node.parent = a:parent

    " Other node properties
    let Node.empty = 0
    let Node.opened = 0
    let Node.unfolded = 0
    let Node.depth = a:parent.depth + 1

    let Node.path = a:path
    let Node.isdir = isdirectory(a:path)

    " Foreign calls
    let Node.wiki = ''

    " Set up naming
    call Node.parseManifest(a:path)
    let Node.title = get(self.names, a:path, lodestar#cut(a:path))

    return Node
endfunction


" FUNCTION: parseManifest(path) {{{1 
" If a manifest file is present in the current directory, it
" is attempted to be parsed, and the corresponding values
" assigned in the vim environment
" ==============================================================
function s:Node.parseManifest(path)
python << endpython

# Will be paired to g:LodestarNode's static members
names = {}
ignore = {}

# Only continue if file exists & is syntactically correct
path = vim.eval('a:path')
manifest_path = abs_path(path, 'manifest.json')

try:
    with open(manifest_path, 'r') as man_fp:
        manifest = json.load(man_fp, object_hook = decode)

        # The title represents the name of the current lode
        # This value could be overridden by lodes deeper in the
        # tree directory
        if manifest.has_key('Title'): names[path] = manifest['Title']

        # Ignores the manifest file by default
        ignore[manifest_path] = 1
        for i in manifest.get('Ignore', []):
            ignore[abs_path(path, i)] = 1

        # Reads in local links, pairing each to its own name
        # This value defaults to the filename if not specified
        links = manifest.get('Links', {})
        for name, addr in links.iteritems():
            names[abs_path(path, addr)] = name

        # Passing the values to the Vim environment
        vim.command('call extend(self.names, {})'.format(names))
        vim.command('call extend(self.ignore, {})'.format(ignore))

        # Read in wikipedia page if available
        if manifest.has_key('Wikipedia'):
            vim.command("let self.wiki = '{}'".format(manifest['Wikipedia']))

except IOError:
    print('{} skipped: no manifest file'.format(path))

except ValueError:
    print("{}'s manifest file syntactically incorrect".format(path))

endpython
endfunction


" FUNCTION: screenName() {{{1 Get screen name
" ==============================================================
function s:Node.screenName()
    let depth_marker = repeat('|', self.depth)
    if self.empty
        let type_marker = '#'
    elseif !self.isdir
        let type_marker = '~'
    else
        let type_marker = self.unfolded ? '-' : '+'
    endif

    return depth_marker . type_marker . self.title
endfunction


" FUNCTION: active() {{{1 Get's currently selected subnode
" Before this is called, it should be checked whether or not
" the node is empty or not
" ==============================================================
function s:Node.active()
    return self.links[self.pos]
endfunction


" FUNCTION: compare(node) {{{1 For sorting purposes
" ==============================================================
function s:Node.compare(node)
    if self.title < a:node.title 
        return -1
    elseif self.title > a:node.title
        return 1
    else
        return 0
    endif
endfunction


" FUNCTION: coverage() {{{1 Number of lines the node covers
" ==============================================================
function s:Node.coverage()
    let total = 1
    if self.unfolded
        for link in self.links
            let tmp = link.coverage()
            let total = total + tmp
        endfor 
    endif
    return total
endfunction


" FUNCTION: open() {{{1 Populates links of current node
" ==============================================================
function s:Node.open()
    let self.opened = 1
    
    " Read in files of current directory
    for path in glob(lodestar#join(self.path, '*'), 0, 1)
        if !has_key(self.ignore, path)
            let tmp = g:LodestarNode.new(path, self)
            call add(self.links, tmp)
        endif
    endfor

    " Order correctly
    let self.empty = empty(self.links)
    call lodestar#quicksort(self.links)
endfunction


" FUNCTION: toggle() {{{1 Show/hide node contents
" May pass in a flag to represent refresh the contents
" ==============================================================
function s:Node.toggle()
    if self.isdir
        if !self.opened
            call self.open()
        endif

        " Maintains correct scrolling (which checks unfolded)
        if !self.empty
            let self.unfolded = !self.unfolded
        endif
    endif
endfunction

