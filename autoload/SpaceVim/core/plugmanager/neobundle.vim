" TODO

let s:SYS = SpaceVim#api#import('system')


function! SpaceVim#core#plugmanager#neobundle#init(plugin_dir) abort
  if filereadable(expand(a:plugin_dir)
        \ . 'neobundle.vim' . s:SYS.Fsep . 'README.md')
    let g:_spacevim_neobundle_installed = 1
  else
    if executable('git')
      exec '!git clone '
            \ .'https://github.com/'
            \ .'Shougo/neobundle.vim'
            \ . ' '
            \ . fnameescape(a:plugin_dir)
            \ . 'neobundle.vim'
      let g:_spacevim_neobundle_installed = 1
    else
      echohl WarningMsg
      echom 'You need install git!'
      echohl None
    endif
  endif
  exec 'set runtimepath+='
        \ . fnameescape(a:plugin_dir)
        \ . 'neobundle.vim'
endfunction

function! SpaceVim#core#plugmanager#neobundle#begin(plugin_dir) abort
  call neobundle#begin(a:plugin_dir)
endfunction

function! SpaceVim#core#plugmanager#neobundle#defind_hooks(bundle) abort
  let s:hooks = neobundle#get_hooks(a:bundle)
  func! s:hooks.on_source(bundle) abort
      call SpaceVim#utils#source_rc('plugins/' . split(a:bundle['name'],'\.')[0] . '.vim')
  endfunction
endfunction


function! SpaceVim#core#plugmanager#neobundle#end() abort
  call neobundle#end()
  if g:spacevim_checkinstall == 1
      silent! let g:_spacevim_checking_flag = neobundle#exists_not_installed_bundles()
      if g:_spacevim_checking_flag
          augroup SpaceVimCheckInstall
              au!
              au VimEnter * SPInstall
          augroup END
      endif
  endif
endfunction
