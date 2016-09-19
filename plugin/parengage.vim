" Parengage

" Setup function

function! Parengage()
    inoremap <buffer> <expr> ( parengage#open_round()
endfunction

" Commands section

function! parengage#open_round()
    return '()'
endfunction
