if exists('g:loaded_LodestarMenu')
    finish
endif | let g:loaded_LodestarMenu = 1

let s:ls_menu = {}
let g:LodestarMenu = s:ls_menu

" FUNCTION: Constructor {{{1
function! s:ls_menu.New()
    let ls_menu = copy(self)
    let ls_menu.links = {}
    let ls_menu.upper_bound = 0

    call ls_menu.Init()
    call ls_menu.Unfold()
    call ls_menu.DrawHeader()
    call ls_menu.DrawLinks()

    return ls_menu
endfunction

" FUNCTION: Initializer {{{1
" Set up window/buffer options.
function! s:ls_menu.Init()
    au BufEnter LodestarMenu :echo 'test'

    30vne LodestarMenu
    setlocal cursorline
    setlocal winfixwidth
    hi CursorLine term=bold ctermfg=Cyan
endfunction

" FUNCTION: Unfold {{{1
" Returns all links of menu
function! s:ls_menu.Unfold()
    let dirs = g:lodestar#lodes_path . '/*'
    echo dirs
    for path in glob(dirs, 0, 1)
        if isdirectory(path)
            let tmp = g:LodestarLode.New(path)
            let self.links[tmp.title] = tmp
        endif
    endfor
endfunction

" FUNCTION: DrawHeader {{{1
" Writes the specified header to the current buffer.
function! s:ls_menu.DrawHeader()
    let header = [
        \ '-----Lodestar Menu-----',
        \ '=======================']

    let i = 0
    for line in header
        call append(i, line)
        let i = i + 1
    endfor

    " Ensures user won't enter header
    let self.upper_bound = i + 1
endfunction

" FUNCTION: DrawLinks {{{1
" Writes all available links starting at the menus
" upper bound
function! s:ls_menu.DrawLinks()
    let i = self.upper_bound
    let ordered = sort(keys(self.links)) 
    for link in ordered
        call append(i, link)        
        let i = i + 1
    endfor

    " Moves cursor to first link
    if !empty(ordered)
        call setpos('.', [0, self.upper_bound + 1, 0, 0])
    endif
endfunction
