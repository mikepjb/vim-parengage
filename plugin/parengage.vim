" Parengage

" TODO uncomment when finished...
" if &cp || exists( 'g:parengage_loaded' )
"     finish
" endif
"
" let g:parengage_loaded = 1

" Setup function

function! Parengage()
    inoremap <buffer> <expr> ( parengage#open_round()
    inoremap <buffer> <expr> ) parengage#close_round()
    inoremap <buffer> <expr> [ parengage#open_square()
    inoremap <buffer> <expr> ] parengage#close_square()
    inoremap <buffer> <expr> { parengage#open_curly()
    inoremap <buffer> <expr> } parengage#close_curly()
    inoremap <buffer> <expr> " parengage#open_double_quote()
    inoremap <buffer> <expr>  parengage#delete_character()
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

function! parengage#delete_character()
    let previous_char = matchstr(getline('.'), '\%' . (col('.')-1) . 'c.')
    let current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if current_char == ")" && previous_char == "("
        return "\<Left>\<C-o>2s"
    elseif previous_char == ")"
        return "\<Left>"
    else
        return "\<BS>"
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

" curly section

function! parengage#open_curly()
    return "{}\<Left>"
endfunction


function! parengage#close_curly()
    let current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if current_char == "}"
        return "\<Right>"
    else
        return "}"
    endif
endfunction

function! parengage#open_double_quote()
    return "\"\"\<Left>"
endfunction


au FileType *clojure* call Parengage()
