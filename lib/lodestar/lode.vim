" ==============================================================
" File:         lode.vim
" Description:  Represents a reference for lookups
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_LodestarLode') | finish | endif

let s:lode = g:LodestarNode.New()
let g:LodestarLode = s:lode


" FUNCTION: New(path, parent) {{{1 Constructor
" ==============================================================
function! s:lode.New(parent, path)
    let lode = deepcopy(self)
    
    let lode.path = a:path
    let lode.parent = a:parent
    let lode.names = a:parent.names

    call lode.ParseManifest()
    let lode.isdirectory = 1
    let lode.title = lode.Title()

    return lode
endfunction


" FUNCTION: ParseManifest() {{{1 Read mandatory manifest file
" The manifest allows convenient, user-defined configurations
" ==============================================================
function s:lode.ParseManifest()
python << endpython

path = vim.eval('self.path')
man_path = abs_path(path) + '/manifest.json'
ignore_paths = [man_path]

try:
    with open(man_path, 'r') as man_fp:
        man_js = json.load(man_fp, object_hook = decode)
        man = defaultdict(str, man_js)

        # One to one mapping of manifest to lode
        vim.command("let self.category = '{}'".format(man['Category']))
        vim.command("let self.names['{}'] = '{}'".format(path, man['Title']))

        #Ignore files
        ignore_paths.extend([link for link in man['Ignore']])
        vim.command("let self.ignore = {}".format(ignore_paths))

        # Pair paths to desired names
        for link in man['Links']:
            name, addr = link.popitem()
            addr = abs_path(path, addr)
            if addr not in ignore_paths:
                vim.command("let self.names['{}'] = '{}'".format(addr, name))

except IOError:
    print("{} does not exist!".format(path))
except ValueError:
    print("{} improperly formatted".format(path))

endpython
endfunction
