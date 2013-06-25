" ==============================================================
" File:         lodestar.vim
" Description:  Vim plugin for quick lookup of compsci topics
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_Lodestar') | finish | endif
runtime lib/lodestar/keymap.vim
runtime lib/lodestar/node.vim
runtime lib/lodestar/lode.vim
runtime lib/lodestar/category.vim
runtime lib/lodestar/menu.vim


" Python v2.7 {{{1 Used to parse manifest files in lodes.
" ==============================================================
if has('python')
python << endpython
import os.path
import vim, json
from collections import defaultdict

def decode(member):
    """ Converts json object to usable Vim object 

    In Python 2.7 a json object, by default, returns all string
    representations in unicode. The 'u' prefix makes equating this 
    value to a vim string difficult. Loading this function as the
    an object hook in the json module's load function solves this.

    """
    if isinstance(member, dict):
        return { decode(k) : decode(v) for k, v in member.iteritems() }
    elif isinstance(member, list):
        return [ decode(k) for k in member ]
    elif isinstance(member, unicode):
        return member.encode('utf-8')
    else:
        return member

def abs_path(base, rel = ''):
    """ Finds the absolute path of path in terms of base

    Because the links in the manifest files present in lodes
    are defined relative to the current lode, it is necessary
    to expand the path names for proper naming purposes.

    """
    base_path = os.path.expanduser(base)
    return os.path.abspath(base_path + '/' + rel)

endpython
else
    echo "Please compile vim with +python"
    finish
endif


" Custom map {{{1 Map <Plug>LodestarMain in .vimrc
" ==============================================================
if !hasmapto('<Plug>LodestarMain')
    map <unique> <F2> <Plug>LodestarMain
endif
noremap <unique> <script> <Plug>LodestarMain <SID>Main
noremap <unique> <script> <SID>Main    :call <SID>Main()<CR>


" FUNCTION: Main() {{{1 Program called here
" ==============================================================
function s:Main()
    let title = 'LodestarMenu_' . g:LodestarBufferCount
    let lodestar = g:LodestarMenu.New(title)

    let g:LodestarBufferMap[title] = lodestar
    let g:LodestarBufferCount = g:LodestarBufferCount + 1

    exe "au BufEnter " . title . " :call g:LodestarKeyMap()"
    call g:LodestarKeyMap()
endfunction
