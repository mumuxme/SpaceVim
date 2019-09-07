let s:save_cpo = &cpo
set cpo&vim

let s:plugins = []
let g:_spacevim_plugins = []
let s:plugin_dir = g:spacevim_plugin_bundle_dir


function! SpaceVim#core#plugmanager#init(plugin_dir) abort

  " -- dein
  if g:spacevim_plugin_manager ==# 'dein'
    call SpaceVim#core#plugmanager#dein#init(s:plugin_dir)

  " -- neobundle
  elseif g:spacevim_plugin_manager ==# 'neobundle'
    call SpaceVim#core#plugmanager#neobundle#init(s:plugin_dir)

  " -- vim-plug
  elseif g:spacevim_plugin_manager ==# 'vim-plug'
    call SpaceVim#core#plugmanager#vimplug#init(s:plugin_dir)

  endif
endfunction

" TODO
if get(g:,'spacevim_enable_plugins', 1)
  call SpaceVim#core#plugmanager#dein#init(s:plugin_dir)
endif

" --------------------------------

function! SpaceVim#core#plugmanager#begin() abort
  " TODO
  let g:unite_source_menu_menus.AddedPlugins =
              \ {'description':
              \ 'All the Added plugins'
              \ . '                    <leader>lp'}
  let g:unite_source_menu_menus.AddedPlugins.command_candidates = []
  nnoremap <silent><Leader>lp :Unite -silent
              \ -winheight=17 -start-insert menu:AddedPlugins<CR>

  " -- dein
  if g:spacevim_plugin_manager ==# 'dein'
    call SpaceVim#core#plugmanager#dein#begin(s:plugin_dir)

  " -- neobundle
  elseif g:spacevim_plugin_manager ==# 'neobundle'
    call SpaceVim#core#plugmanager#neobundle#begin(s:plugin_dir)

  " -- vim-plug
  elseif g:spacevim_plugin_manager ==# 'vim-plug'
    call SpaceVim#core#plugmanager#vimplug#begin(s:plugin_dir)

  endif
endfunction


function! SpaceVim#core#plugmanager#end() abort
  " -- dein
  if g:spacevim_plugin_manager ==# 'dein'
    call SpaceVim#core#plugmanager#dein#end()

  " -- neobundle
  elseif g:spacevim_plugin_manager ==# 'neobundle'
    call SpaceVim#core#plugmanager#neobundle#end()

  " -- vim-plug
  elseif g:spacevim_plugin_manager ==# 'vim-plug'
    call SpaceVim#core#plugmanager#vimplug#end()

  endif
endfunction


function! SpaceVim#core#plugmanager#add(repo, ...) abort
  " TODO: remove
  " current plugin name
  let g:spacevim_plugin_name = ''

  " -- dein
  if g:spacevim_plugin_manager ==# 'dein'
    if len(a:000) > 0
      call dein#add(a:repo, a:000[0])
    else
      call dein#add(a:repo)
    endif
    let g:spacevim_plugin_name = g:dein#name
    call add(g:_spacevim_plugins, g:dein#name)

  " -- neobundle
  elseif g:spacevim_plugin_manager ==# 'neobundle'
    exec 'NeoBundle "'.a:repo.'"'.','.join(a:000,',')
    let g:spacevim_plugin_name = split(a:repo, '/')[-1]

  " -- vim-plug
  elseif g:spacevim_plugin_manager ==# 'vim-plug'
    if len(a:000) > 0
        exec "Plug '".a:repo."', ".join(a:000,',')
    else
        exec "Plug '".a:repo."'"
    endif
    let g:spacevim_plugin_name = split(a:repo, '/')[-1]
  endif

  " TODO
  let str = get(g:,'_spacevim_plugin_layer', 'custom plugin')
  let str = '[' . str . ']'
  let str = str . repeat(' ', 25 - len(str))
  exec 'call add(g:unite_source_menu_menus'
        \ . '.AddedPlugins.command_candidates, ["'. str . '['
        \ . a:repo
        \ . (len(a:000) > 0 ? (']'
        \ . repeat(' ', 40 - len(a:repo))
        \ . '[lazy loaded]  [' . string(a:000[0])) : '')
        \ . ']","OpenBrowser https://github.com/'
        \ . a:repo
        \ . '"])'

  call add(s:plugins, a:repo)
endfunction


function! SpaceVim#core#plugmanager#defind_hooks(bundle) abort
  " -- dein
  "  FIXME: also pass `a:bundle` as an argument to dein define_hooks function?
  if g:spacevim_plugin_manager ==# 'dein'
    call SpaceVim#core#plugmanager#dein#defind_hooks()

  " -- neobundle
  elseif g:spacevim_plugin_manager ==# 'neobundle'
    call SpaceVim#core#plugmanager#neobundle#defind_hooks(a:bundle)

  endif
endfunction


function! SpaceVim#core#plugmanager#tap(plugin) abort
  if g:spacevim_plugin_manager ==# 'dein'
    return dein#tap(a:plugin)
  elseif g:spacevim_plugin_manager ==# 'neobundle'
    return neobundle#tap(a:plugin)
  endif
endfunction


function! SpaceVim#core#plugmanager#is_plugmanager_installed() abort
  return g:_spacevim_neobundle_installed
        \ || g:_spacevim_dein_installed
        \ || g:_spacevim_vim_plug_installed
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
