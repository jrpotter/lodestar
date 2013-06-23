" A lode represents a reference page for use in vim. It
" will eventually include the opening of custom pages,
" wikipedia articles, and more.
" 
" Maintainer: Joshua Potter
" Contact: jrpotter@live.unc.edu
if exists('g:loaded_LodestarLode')
    finish
endif | let g:loaded_LodestarLode = 1

" Initialize
runtime! plugin/lodestar/Node.vim
let s:ls_lode = g:LodestarNode.New()
let g:LodestarLode = s:ls_lode

" FUNCTION: New(path, parent) {{{1
function! s:ls_lode.New(path, parent)
    let lode = copy(self)

    let lode.category = ''
    let lode.path = a:path
    let lode.parent = a:parent
    let lode.depth = a:parent.depth + 1

    call lode.ParseManifest()

    return lode
endfunction

" FUNCTION: ParseManifest() {{{1
" Reads in manifest file at current path for
" proper organization, naming, etc.
function! s:ls_lode.ParseManifest()
python << endpython

path = vim.eval('self.path')
man_path = path + '/manifest.json'

try:
    with open(man_path, 'r') as manifest:
        man = json.load(manifest, object_hook = uni_asc)

        # One to one pairing of manifest members to self members
        vim.command("let self.title = '{}'".format(man['Title']))
        vim.command("let self.category = '{}'".format(man['Category']))
        vim.command("let self.names['{}'] = '{}'".format(path, man['Title']))

        # Pairs up names to paths
        for link in man['Links']:
            for name, addr in link.iteritems():
                vim.command("let self.names['{}'] = '{}'".format(addr, name))

except KeyError: #struct accessing
    print("{} is incomplete!".format(path))
except IOError: #Opening manifest
    print("{} does not exist!".format(path))
except ValueError: #json loading
    print("{} is improperly formatted!".format(path))

endpython
endfunction

