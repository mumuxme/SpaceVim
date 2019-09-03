" --------------------------------------
" convenient keybindings for operating with buffer
" --------------------------------------


function! SpaceVim#layers#mapping#buffer#plugins() abort
  return []
endfunction

function! SpaceVim#layers#mapping#buffer#config() abort
  " move between buffers
  nnoremap <silent> > :<c-u>bn<cr>
  nnoremap <silent> < :<c-u>bN<cr>

  if SpaceVim#layers#isLoaded('denite')
    call s:search_buffer_by_denite()
  endif
endfunction

" --------------------------------------

function! s:search_buffer_by_denite() abort
  nnoremap <silent> <c-j> :Denite buffer<cr>
endfunction
