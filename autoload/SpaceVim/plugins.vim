"=============================================================================
" plugins.vim --- plugin wrapper
"=============================================================================
scriptencoding utf-8

function! SpaceVim#plugins#load() abort
  " TODO: remove
  "if zvim#plug#enable_plug()
  "  call zvim#plug#begin(g:spacevim_plugin_bundle_dir)
  "  call zvim#plug#fetch()
  "  call s:load_plugins()
  "  call s:disable_plugins(g:spacevim_disabled_plugins)
  "  call zvim#plug#end()
  "endif

  if SpaceVim#core#plugmanager#is_plugmanager_installed()
    call SpaceVim#core#plugmanager#begin()
    call s:load_plugins()
    call s:disable_plugins(g:spacevim_disabled_plugins)
    call SpaceVim#core#plugmanager#end()
  endif
endfunction

function! s:load_plugins() abort
  for group in SpaceVim#layers#get()
    let g:_spacevim_plugin_layer = group
    for plugin in s:getLayerPlugins(group)
      if len(plugin) == 2
        call zvim#plug#add(plugin[0], plugin[1])
        if zvim#plug#tap(split(plugin[0], '/')[-1]) && get(plugin[1], 'loadconf', 0 )
          call zvim#plug#defind_hooks(split(plugin[0], '/')[-1])
        endif
        if zvim#plug#tap(split(plugin[0], '/')[-1]) && get(plugin[1], 'loadconf_before', 0 )
          call zvim#plug#loadPluginBefore(split(plugin[0], '/')[-1])
        endif
      else
        call zvim#plug#add(plugin[0])
      endif
    endfor
    call s:loadLayerConfig(group)
  endfor
  unlet g:_spacevim_plugin_layer
  for plugin in g:spacevim_custom_plugins
    if len(plugin) == 2
      call zvim#plug#add(plugin[0], plugin[1])
    else
      call zvim#plug#add(plugin[0])
    endif
  endfor
endfunction

function! s:getLayerPlugins(layer) abort
  try
    return SpaceVim#layers#{a:layer}#plugins()
  catch /^Vim\%((\a\+)\)\=:E117/
  endtry
  return []
endfunction

function! s:loadLayerConfig(layer) abort
  try
    call SpaceVim#layers#{a:layer}#config()
  catch /^Vim\%((\a\+)\)\=:E117/
  endtry
endfunction

function! s:disable_plugins(plugin_list) abort
  if g:spacevim_plugin_manager ==# 'dein'
    for name in a:plugin_list
      call dein#disable(name)
    endfor
  elseif g:spacevim_plugin_manager ==# 'neobundle'
    for name in a:plugin_list
      call neobundle#config#disable(name)
    endfor
  endif
endfunction

function! SpaceVim#plugins#get(...) abort

endfunction

" vim:set et sw=2:
