" --------------------------------------
" convenient keybindings for operating with register
" --------------------------------------

function! SpaceVim#layers#mapping#register#plugins() abort
  return []
endfunction


function! SpaceVim#layers#mapping#register#config() abort
  call s:delete_yank_put()
endfunction

" --------------------------------------

function! s:delete_yank_put() abort
  " X11-based systems have two independent clipboards:
  " PRIMARY and CLIPBOARD

  " for PRIMARY (copy-on-select)
  noremap <Leader>d "*d
  noremap <Leader>y "*y
  noremap <Leader>p "*p

  " for CLIPBOARD (common keybind, Ctrl-c, Ctrl-v)
  noremap <Leader>D "+d
  noremap <Leader>Y "+y
  noremap <Leader>P "+p
endfunction
