if exists("g:loaded_Lodestar")
    finish
endif | let g:loaded_Lodestar = 1

if !has("python")
    echo "Lodestar makes heavy use of python. Please compile with +python."
    finish
endif

if !hasmapto('<Plug>LodestarMain')
    map <unique> <F2> <Plug>LodestarMain
endif
noremap <unique> <script> <Plug>LodestarMain <SID>Main
noremap <SID>Main :call <SID>Main()<CR>

function! s:Main()
    echo 'test'
endfunction
