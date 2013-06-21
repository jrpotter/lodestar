" Represents a reference page. Called a lode as it is not planned
" for this solely being a reference page.
if exists('g:loaded_LodestarLode')
    finish
endif | let g:loaded_LodestarLode = 1

let s:ls_lode = {}
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

with open(manifest_path, 'r') as manifest:
    struct = json.load(manifest, object_hook = uni_asc)
    vim.command("let self.title = '{}'".format(struct['Title']))

endpython
endfunction

