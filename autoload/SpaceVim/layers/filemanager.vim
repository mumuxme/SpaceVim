function! SpaceVim#layers#filemanager#plugins() abort
  let plugins = []
  call add(plugins, ['Shougo/defx.nvim',{'merged' : 0, 'loadconf' : 1 , 'loadconf_before' : 1}])
  return plugins
endfunction

function! SpaceVim#layers#filemanager#config() abort
  call SpaceVim#mapping#space#def('nnoremap', ['f', 't'], 'Defx', 'toggle-file-tree', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['f', 'T'], 'Defx -no-toggle', 'show-file-tree', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['f', 'o'], "Defx  -no-toggle -search=`expand('%:p')` `stridx(expand('%:p'), getcwd()) < 0? expand('%:p:h'): getcwd()`", 'open-file-tree', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['b', 't'], 'exe "Defx -no-toggle " . fnameescape(expand("%:p:h"))', 'show-file-tree-at-buffer-dir', 1)
endfunction
