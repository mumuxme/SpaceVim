""
" filemanager layer
""

function! SpaceVim#layers#filemanager#plugins() abort
  let plugins = []

  if g:spacevim_filemanager ==# 'nerdtree'
    call add(plugins, ['scrooloose/nerdtree', { 'on_cmd' : 'NERDTreeToggle',
          \ 'loadconf' : 1}])
  elseif g:spacevim_filemanager ==# 'vimfiler'
    call add(plugins, ['Shougo/vimfiler.vim',{'merged' : 0, 'loadconf' : 1 , 'loadconf_before' : 1, 'on_cmd' : ['VimFiler', 'VimFilerBufferDir']}])
    call add(plugins, ['Shougo/unite.vim',{ 'merged' : 0 , 'loadconf' : 1}])
    call add(plugins, ['Shougo/vimproc.vim', {'build' : [(executable('gmake') ? 'gmake' : 'make')]}])
  endif

  return plugins
endfunction


function! SpaceVim#layers#filemanager#config() abort
  if g:spacevim_filemanager ==# 'nerdtree'
    call s:nerdtree_configs()
  elseif g:spacevim_filemanager ==# 'vimfiler'
    call s:vimfiler_configs()
  endif
endfunction

" ----------------------

function! s:nerdtree_configs() abort
  noremap <silent> <F3> :NERDTreeToggle<CR>

  call SpaceVim#mapping#space#def('nnoremap', ['f', 't'], 'NERDTreeToggle', 'toggle_file_tree', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['f', 'T'], 'NERDTree', 'show_file_tree', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['f', 'o'], 'NERDTreeFind', 'open_file_tree', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['b', 't'], 'NERDTree %', 'show_file_tree_at_buffer_dir', 1)
endfunction


function! s:vimfiler_configs() abort
  call SpaceVim#mapping#space#def('nnoremap', ['f', 't'], 'VimFiler', 'toggle_file_tree', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['f', 'T'], 'VimFiler -no-toggle', 'show_file_tree', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['f', 'o'], 'VimFiler -find', 'open_file_tree', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['b', 't'], 'VimFilerBufferDir -no-toggle', 'show_file_tree_at_buffer_dir', 1)
endfunction
