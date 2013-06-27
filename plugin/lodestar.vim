" ==============================================================
" File:         lodestar.vim
" Description:  Vim plugin for quick lookup of compsci topics
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
"
" ==============================================================

if lodestar#guard('g:loaded_Lodestar') | finish | endif
if !has('python') | echo 'Compile with +python' | finish | endif

" Global vim files
runtime lib/lodestar/python.vim
runtime lib/lodestar/keymap.vim

" Nodes
runtime lib/lodestar/node.vim
runtime lib/lodestar/lode.vim

" Fake nodes
runtime lib/lodestar/fake_node.vim
runtime lib/lodestar/category.vim
runtime lib/lodestar/wiki.vim
runtime lib/lodestar/menu.vim


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

    "Testing
python << endpython
wiki = WikiHandler('jrpotter@live.unc.edu')
print wiki.parse('AVL_tree')

endpython
    call getchar();

    let title = 'LodestarMenu_' . g:LodestarBufferCount
    let lodestar = g:LodestarMenu.New(title)

    let g:LodestarBufferMap[title] = lodestar
    let g:LodestarBufferCount = g:LodestarBufferCount + 1

    exe "au BufEnter " . title . " :call g:LodestarKeyMap()"
    call g:LodestarKeyMap()
endfunction
