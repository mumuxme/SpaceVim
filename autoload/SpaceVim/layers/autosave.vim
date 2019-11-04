function! SpaceVim#layers#autosave#plugins() abort
  return [
        \ ['907th/vim-auto-save', {'merged': 0}]
        \ ]
endfunction

function! SpaceVim#layers#autosave#config() abort
  let g:auto_save = 1
  let g:auto_save_events = ['InsertLeave']
endfunction
