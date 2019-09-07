" --------------------------------------
" utils
" --------------------------------------


function! SpaceVim#utils#source_rc(file) abort
  if filereadable(g:_spacevim_root_dir. '/' . a:file)
    execute 'source ' . g:_spacevim_root_dir  . '/' . a:file
  endif
endfunction
