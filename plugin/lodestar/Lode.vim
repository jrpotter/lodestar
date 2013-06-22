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

" FUNCTION: New(path) {{{1
function! s:ls_lode.New(path)
    let lode = copy(self)

    let lode.path = a:path
    call lode.ParseManifest()

    return lode
endfunction

" FUNCTION: ParseManifest() {{{1
" Reads in manifest file at current path for
" proper organization, naming, etc.
function! s:ls_lode.ParseManifest()
python << endpython

path = vim.eval('self.path . g:lodestar#sep')
manifest_path = path + vim.eval('g:lodestar#manifest')

try:
    with open(manifest_path, 'r') as manifest:
        struct = json.load(manifest, object_hook = uni_asc)
        vim.command("let self.title = '{}'".format(struct['Title']))

        # Pairs up names to paths for unfolding later on
        for link in struct['Links']:
            for name, addr in link.iteritems():
                vim.command("let self.names['{}'] = '{}'".format(addr, name))

except IOError: #Opening manifest
    print("{} does not exist!".format(manifest_path))
except KeyError: #struct accessing
    print("{} is incomplete!".format(manifest_path))
except ValueError: #json loading
    print("{} is improperly formatted!".format(manifest_path))

endpython
endfunction

