" layer for coq proof assistant.

function! SpaceVim#layers#lang#coq#plugins() abort
  " FIXME
  " [coquille](https://github.com/the-lambda-church/coquille) require this vimbufsync,
  " (Parts of Coqtail were originally inspired by/adapted from Coquille)
  " See this issue: [Remove the dependency from vimbufsync](https://github.com/whonore/Coqtail/issues/58)
  " or this fork: <https://framagit.org/tyreunom/coquille>
  "
  " Currently: only syntax and index are used.
  return [
        \ ['let-def/vimbufsync', {'merged' : 0}],
        \ ['whonore/Coqtail', {'merged' : 0}],
        \ ]
endfunction


function! SpaceVim#layers#lang#coq#config() abort
endfunction
