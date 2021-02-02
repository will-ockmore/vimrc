""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

""""""""""""""""""""""""""""""
" => Racket section
""""""""""""""""""""""""""""""
if has("autocmd")
    au BufReadPost *.rkt,*.rktl set filetype=scheme
endif

