set number
syntax on
let g:netrw_banner = 0

let g:netrw_liststyle = 3

let g:netrw_browse_split = 4

let g:netrw_altv = 1

let g:netrw_winsize = 20

augroup ProjectDrawer

  autocmd!

  autocmd VimEnter * :Vexplore

augroup END

