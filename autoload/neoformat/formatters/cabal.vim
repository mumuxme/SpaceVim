function! neoformat#formatters#cabal#enabled() abort
  return ['stylishcabal']
endfunction

function! neoformat#formatters#cabal#stylishcabal() abort
  return {
        \ 'exe': 'stylish-cabal',
        \ 'args': [],
        \ 'stdin': 1
        \ }
endfunction
