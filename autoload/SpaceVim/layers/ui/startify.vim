" layer for start screen.
"
" plugins:
"   - https://github.com/mhinz/vim-startify

function! SpaceVim#layers#ui#startify#plugins()
  let plugins = [
        \ ['mhinz/vim-startify', {'merged' : 0}],
        \ ]
  return plugins
endfunction

function! SpaceVim#layers#ui#startify#config()
  call s:set_configs()
  call s:set_keymaps()
  call s:set_fileicon()

  augroup startify_map
    au!
    autocmd FileType startify nnoremap <buffer> <F2> <Nop>
    if !exists('g:startify_custom_header')
      autocmd FileType startify call <SID>update_logo()
    endif
    autocmd FileType startify setl nowrap
  augroup END

  if !exists('g:startify_custom_header')
    call s:update_logo()
  endif
endfunction

" --------------------------------------

function! s:update_logo()
  " NOTE: you must have `cowsay` and `fortunes` installed
  let g:startify_custom_header =
        \ map(split(system('fortune -s | cowsay'), '\n'), '"   ". v:val')
endfunction

function! s:set_configs()
  let g:startify_files_number = 6
  let g:startify_lists = [
        \ { 'type': 'dir', 'header': ['   MRU '. getcwd()] },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
  let g:startify_update_oldfiles = 1
  let g:startify_disable_at_vimenter = 1
  let g:startify_session_autoload = 1
  let g:startify_session_persistence = 1
  let g:startify_change_to_dir = 0
  "let g:startify_change_to_vcs_root = 0  " vim-rooter has same feature
  let g:startify_skiplist = [
        \ 'COMMIT_EDITMSG',
        \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
        \ 'bundle/.*/doc',
        \ ]
endfunction

function! s:set_fileicon() abort
  let s:FILE = SpaceVim#api#import('file')

  if g:spacevim_enable_tabline_filetype_icon
    function! FileIcon(path)
      let icon = s:FILE.fticon(a:path)
      return empty(icon) ? ' ' : icon
    endfunction

    " Changing the entry format
    function! StartifyEntryFormat()
      return 'FileIcon(entry_path) ."  ". entry_path'
    endfunction
  endif
endfunction

function! s:set_keymaps()
  call SpaceVim#mapping#space#def('nnoremap', ['a', 's'], 'Startify | doautocmd WinEnter', 'fancy start screen', 1)
  call SpaceVim#mapping#space#def('nnoremap', ['b', 'H'], 'Startify', 'home', 1)
endfunction
