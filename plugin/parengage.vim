" Parengage

" TODO uncomment when finished...
" TODO at some point you should be generalising commands
" like slurp right/left
" if &cp || exists( 'g:parengage_loaded' )
"     finish
" endif
"
" let g:parengage_loaded = 1

" Setup function

" Links keybindings to parengage function
function! Parengage()
    if !has('nvim')
        set <M-k>=k
        set <M-l>=l
    endif

    inoremap <M-k> <C-o>:call parengage#slurp_right()<CR>
    map <M-k> :call parengage#slurp_right()<CR>
    inoremap <M-l> <C-o>:call parengage#barf_right()<CR>
    map <M-l> :call parengage#barf_right()<CR>
    inoremap <buffer> <expr> ( parengage#open_round()
    inoremap <buffer> <expr> ) parengage#close_round()
    inoremap <buffer> <expr> [ parengage#open_square()
    inoremap <buffer> <expr> ] parengage#close_square()
    inoremap <buffer> <expr> { parengage#open_curly()
    inoremap <buffer> <expr> } parengage#close_curly()
    inoremap <buffer> <expr> " parengage#open_double_quote()
    inoremap <buffer> <expr>  parengage#delete_character()

    if has('nvim')
        tnoremap <buffer> <expr> ( parengage#open_round()
        tnoremap <buffer> <expr> ) parengage#close_round()
        tnoremap <buffer> <expr> [ parengage#open_square()
        tnoremap <buffer> <expr> ] parengage#close_square()
        tnoremap <buffer> <expr> { parengage#open_curly()
        tnoremap <buffer> <expr> } parengage#close_curly()
        tnoremap <buffer> <expr> " parengage#open_double_quote()
        tnoremap <buffer> <expr> ^? parengage#delete_character()
    endif
endfunction

" Balancing section

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

" Commands section

" TODO move to/create helper section
function! s:letter_under_cursor()
    return matchstr(getline('.'), '\%' . col('.') . 'c.')
endfunction

function! parengage#slurp_right()
    if s:letter_under_cursor() != ')'
        normal f)
    endif
    normal "yx
    " you will likely need a conditional to check that a paren is not already
    " side by side to another before searching. )) will stay as ))
    normal / \|)
    normal "yP
endfunction

function! parengage#barf_right()
    if s:letter_under_cursor() != ')'
        normal f)
    endif
    normal Bh"ydt)"yp
endfunction

au FileType *clojure* call Parengage()
