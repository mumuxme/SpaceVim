""
" dein.vim: https://github.com/Shougo/dein.vim
""
let s:SYS = SpaceVim#api#import('system')


function! SpaceVim#core#plugmanager#dein#init(plugin_dir) abort
  " FIXME: this way to check dein has installed or not is not safety.
  if filereadable(expand(a:plugin_dir)
        \ . join(['repos', 'github.com',
        \ 'Shougo', 'dein.vim', 'README.md'],
        \ s:SYS.Fsep))
    " FIXME: do we really need this global variable?
    let g:_spacevim_dein_installed = 1
  else
    if executable('git')
      exec '!git clone https://github.com/Shougo/dein.vim "'
            \ . expand(g:spacevim_plugin_bundle_dir)
            \ . join(['repos', 'github.com',
            \ 'Shougo', 'dein.vim"'], s:SYS.Fsep)
      " FIXME: do we really need this global variable?
      let g:_spacevim_dein_installed = 1
    else
      echohl WarningMsg
      echom 'You need install git!'
      echohl None
    endif
  endif

  exec 'set runtimepath+='. fnameescape(a:plugin_dir)
        \ . join(['repos', 'github.com', 'Shougo',
        \ 'dein.vim'], s:SYS.Fsep)
endfunction


function! SpaceVim#core#plugmanager#dein#begin(plugin_dir) abort
  call dein#begin(a:plugin_dir)

  " let dein manage dein
  call dein#add('Shougo/dein.vim')
endfunction


function! SpaceVim#core#plugmanager#dein#defind_hooks() abort
  " load plugin configs in 'plugins/<plugin-name>.vim'
  call dein#config(g:dein#name, {
              \ 'hook_source' : "call SpaceVim#utils#source_rc('plugins/" . split(g:dein#name,'\.')[0] . ".vim')"
              \ })
endfunction


function! SpaceVim#core#plugmanager#dein#end() abort
  call dein#end()

  if g:spacevim_checkinstall == 1
      silent! let g:_spacevim_checking_flag = dein#check_install()
      if g:_spacevim_checking_flag
          augroup SpaceVimCheckInstall
              au!
              au VimEnter * SPInstall
          augroup END
      endif
  endif

  call dein#call_hook('source')
endfunction
