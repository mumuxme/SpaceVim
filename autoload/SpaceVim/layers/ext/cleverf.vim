" https://github.com/rhysd/clever-f.vim


function! SpaceVim#layers#ext#cleverf#plugins() abort
  let plugins = [
        \ ['rhysd/clever-f.vim', {'merged' : 0}],
        \ ]
  return plugins
endfunction

function! SpaceVim#layers#ext#cleverf#config() abort
  " search a character only in current line
  let g:clever_f_across_no_line = 1
  let g:clever_f_ignore_case = 0
  let g:clever_f_smart_case = 0

  nnoremap <silent> <C-l> :call clever_f#reset()<CR><C-l>
  map \ <Plug>(clever-f-repeat-forward)
  map , <Plug>(clever-f-repeat-back)
endfunction
