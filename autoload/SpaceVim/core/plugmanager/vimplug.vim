" TODO

function! SpaceVim#core#plugmanager#vimplug#init(plugin_dir) abort
  if filereadable(expand('~/.cache/vim-plug/autoload/plug.vim'))
    let g:_spacevim_vim_plug_installed = 1
  else
    if executable('curl')
      exec '!curl -fLo '
            \ . '~/.cache/vim-plug/autoload/plug.vim'
            \ . ' --create-dirs '
            \ . 'https://raw.githubusercontent.com/'
            \ . 'junegunn/vim-plug/master/plug.vim'
      let g:_spacevim_vim_plug_installed = 1
    else
      echohl WarningMsg
      echom 'You need install curl!'
      echohl None
    endif
  endif
  exec 'set runtimepath+=~/.cache/vim-plug/'
endfunction


function! SpaceVim#core#plugmanager#vimplug#begin(plugin_dir) abort
  call plug#begin(a:plugin_dir)
endfunction


function! SpaceVim#core#plugmanager#vimplug#end() abort
  call plug#end()
endfunction
