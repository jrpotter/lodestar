" ==============================================================
" File:         Wiki.vim
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
" Description:  Takes in JSON formatted data, querying the 
"               Wikimedia API for the desired data.
"
" ==============================================================


" Initialization {{{1
" ==============================================================
if lodestar#guard('g:loaded_LodestarWiki') | finish | endif

let s:Wiki = copy(g:LodestarNode)
let g:LodestarWiki = s:Wiki


" FUNCTION: new(json) {{{1 Constructor
" Reads in a json object (literally the values in the manifest
" file), and builds the node accordingly
" ==============================================================
function! s:Wiki.new(json)

endfunction
