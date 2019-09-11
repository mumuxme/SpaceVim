" --------------------------------------
" format layer
"
" Run Neoformat on save:
" >
"   augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
"   augroup END
" <
" --------------------------------------

function! SpaceVim#layers#format#plugins() abort
  return [
        \ ['sbdchd/neoformat', {'merged' : 0}],
        \ ]
endfunction


function! SpaceVim#layers#format#config() abort
  call SpaceVim#mapping#space#def('nnoremap', ['b', 'f'], 'Neoformat', 'format-code', 1)
endfunction
