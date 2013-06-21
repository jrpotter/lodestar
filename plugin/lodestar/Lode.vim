" Represents a reference page. Called a lode as it is not planned
" for this solely being a reference page.
if exists('g:loaded_LodestarLode')
    finish
endif | let g:loaded_LodestarLode = 1

runtime! plugin/lodestar/Node.vim
let s:ls_lode = g:LodestarNode.New()
let g:LodestarLode = s:ls_lode

" FUNCTION: Constructor {{{1
function! s:ls_lode.New(path)
    let lode = copy(self)
    let lode.path = a:path

    call lode.Parse()

    return lode
endfunction

" FUNCTION: Parse {{{1
" Reads in manifest file at current path for
" proper organization, naming, etc.
function! s:ls_lode.Parse()
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

