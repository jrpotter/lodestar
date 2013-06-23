" A quick reference plugin for computer science related
" topics such as data structures, algorithms, etc.
"
" Maintainer: Joshua Potter
" Contact: jrpotter@live.unc.edu
if exists("g:loaded_Lodestar")
    finish
endif | let g:loaded_Lodestar = 1

" Python 2.7+ must be compiled into vim, as python's json 
" module in particular is used.
if !has("python")
    echo "Please compile with +python."
    finish
endif

python << endpython
import vim, json

def uni_asc(item):
    """ Converts json object to usable Vim object 

    In Python 2.7 a json object, by default, returns all string
    representations in unicode. The 'u' prefixing every string
    makes equating this value to a vim string difficult. Loading
    this function as json.loads object_hook solves the problem

    """
    if isinstance(item, dict):
        return { uni_asc(k) : uni_asc(v) for k, v in item.iteritems() }
    elif isinstance(item, list):
        return [ uni_asc(k) for k in item ]
    elif isinstance(item, unicode):
        return item.encode('UTF-8')
    else:
        return item
endpython

" Override <Plug>LodestarMain for custom mapping
if !hasmapto('<Plug>LodestarMain')
    map <unique> <F2> <Plug>LodestarMain
endif
noremap <unique> <script> <Plug>LodestarMain <SID>Main
noremap <SID>Main :call <SID>Main()<CR>

" FUNCTION: Main() {{{1
" Starting point of lodestar plugin
function! s:Main()
    " Unique Buffer Name
    let title = 'LodestarMenu_' . g:LodestarBufferCount
    let g:LodestarBufferCount = g:LodestarBufferCount + 1

    " Build & map menu
    let menu = g:LodestarMenu.New(title)
    let g:LodestarBufferMap[title] = menu
    exe "au BufEnter " . title . " :call g:LodestarKeyMap()"

    " Begin key control
    call g:LodestarKeyMap()
endfunction
