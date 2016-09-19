" Parengage

" Setup function

function! Parengage()
    inoremap <buffer> <expr> ( parengage#open_round()
    inoremap <buffer> <expr> ) parengage#close_round()
    inoremap <buffer> <expr> [ parengage#open_square()
    inoremap <buffer> <expr> ] parengage#close_square()
endfunction

" Commands section

function! parengage#open_round()
    return "()\<Left>"
endfunction


function! parengage#close_round()
    let current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if current_char == ")"
        return "\<Right>"
    else
        return ")"
    endif
endfunction

" TODO find out if current line contains paren with getline('.')
" if it doesn't getline(line('.') - 1) and getline(line('.') + 1)
" phase 1 - do this as far as a blank line, work out phase 2 when you
" have problems

" square section

function! parengage#open_square()
    return "[]\<Left>"
endfunction


function! parengage#close_square()
    let current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if current_char == "]"
        return "\<Right>"
    else
        return "]"
    endif
endfunction
