" SpaceVim.vim --- Initialization and core files for SpaceVim

""
" @section Options, options
" SpaceVim uses `~/.SpaceVim.d/init.toml` as its default global config file.
" You can set all the SpaceVim options and layers in it. `~/.SpaceVim.d/` will
" also be added to runtimepath, so you can write your own scripts in it.
" SpaceVim also supports local config for each project. Place local config
" settings in `.SpaceVim.d/init.toml` in the root directory of your project.
" `.SpaceVim.d/` will also be added to runtimepath.
"
" here is an example setting SpaceVim options:
" >
"   [options]
"     enable-guicolors = true
"     max-column = 120
" <


""
" @section Configuration, config
" If you still want to use `~/.SpaceVim.d/init.vim` as configuration file,
" please take a look at the following options.
"

" return [status, dir]
" status: 0 : no argv
"         1 : dir
"         2 : filename
function! s:parser_argv() abort
  if !argc()
    return [0]
  elseif argv(0) =~# '/$'
    let f = fnamemodify(expand(argv(0)), ':p')
    if isdirectory(f)
      return [1, f]
    else
      return [1, getcwd()]
    endif
  elseif argv(0) ==# '.'
    return [1, getcwd()]
  elseif isdirectory(expand(argv(0)))
    return [1, fnamemodify(expand(argv(0)), ':p')]
  else
    return [2, argv()]
  endif
endfunction

" --------------------------------------

execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/SpaceVim/settings/default.vim'

" TODO options
let g:spacevim_show_cursor_error = 0

" other options
"   g:_spacevim_session_loaded
"   g:_spacevim_checking_flag

" --------------------------------------

function! SpaceVim#welcome() abort
  call SpaceVim#logger#info('=> try to open SpaceVim welcome page')

  if get(g:, '_spacevim_session_loaded', 0) == 1
    call SpaceVim#logger#info('=> start SpaceVim with session file, skip welcome page')
    return
  endif

  exe 'cd' fnameescape(g:_spacevim_enter_dir)

  if exists('g:_spacevim_checking_flag') && g:_spacevim_checking_flag
    return
  endif
  if exists(':Startify') == 2
    Startify
    if isdirectory(bufname(1))
      bwipeout! 1
    endif
  endif

  if g:spacevim_enable_vimfiler_welcome
        \ && get(g:, '_spacevim_checking_flag', 0) == 0
    if exists(':VimFiler') == 2
      VimFiler
      wincmd p
    endif
  endif
endfunction

" ------------------------------------------------------------------------------

function! SpaceVim#begin() abort

  call SpaceVim#utils#source_rc('functions.vim')
  call SpaceVim#utils#source_rc('init.vim')

  " Before loading SpaceVim, We need to parser argvs.
  let s:status = s:parser_argv()
  " If do not start Vim with filename, Define autocmd for opening welcome page
  if s:status[0] == 0
    let g:_spacevim_enter_dir = fnamemodify(getcwd(), ':~')
    call SpaceVim#logger#info('Startup with no argv, current dir is used: ' . g:_spacevim_enter_dir )
    augroup SPwelcome
      au!
      autocmd VimEnter * call SpaceVim#welcome()
    augroup END
  elseif s:status[0] == 1
    let g:_spacevim_enter_dir = fnamemodify(s:status[1], ':~')
    call SpaceVim#logger#info('Startup with directory: ' . g:_spacevim_enter_dir  )
    augroup SPwelcome
      au!
      autocmd VimEnter * call SpaceVim#welcome()
    augroup END
  else
    call SpaceVim#logger#info('Startup with argv: ' . string(s:status[1]) )
  endif
  call SpaceVim#default#options()
  call SpaceVim#default#layers()
  call SpaceVim#default#keyBindings()
  call SpaceVim#commands#load()
endfunction

function! SpaceVim#end() abort
  if g:spacevim_vimcompatible != 1
    call SpaceVim#mapping#def('nnoremap <silent>', '<Tab>', ':wincmd w<CR>', 'Switch to next window or tab','wincmd w')
    call SpaceVim#mapping#def('nnoremap <silent>', '<S-Tab>', ':wincmd p<CR>', 'Switch to previous window or tab','wincmd p')
  endif
  if g:spacevim_vimcompatible == 1
    let g:spacevim_windows_leader = ''
    let g:spacevim_windows_smartclose = 0
  endif

  if !g:spacevim_vimcompatible
    nnoremap <silent><C-x> <C-w>x
    cnoremap <C-f> <Right>
    " Navigation in command line
    cnoremap <C-a> <Home>
    cnoremap <C-b> <Left>
  endif
  call SpaceVim#server#connect()

  if g:spacevim_enable_neocomplcache
    let g:spacevim_autocomplete_method = 'neocomplcache'
  endif
  if g:spacevim_enable_ycm
    if has('python') || has('python3')
      let g:spacevim_autocomplete_method = 'ycm'
    else
      call SpaceVim#logger#warn('YCM need +python or +python3 support, force to using ' . g:spacevim_autocomplete_method)
    endif
  endif
  if g:spacevim_keep_server_alive
    call SpaceVim#server#export_server()
  endif
  if !empty(g:spacevim_windows_leader)
    call SpaceVim#mapping#leader#defindWindowsLeader(g:spacevim_windows_leader)
  endif
  call SpaceVim#mapping#g#init()
  call SpaceVim#mapping#z#init()
  call SpaceVim#mapping#leader#defindKEYs()
  call SpaceVim#mapping#space#init()
  if !SpaceVim#mapping#guide#has_configuration()
    let g:leaderGuide_map = {}
    call SpaceVim#mapping#guide#register_prefix_descriptions('', 'g:leaderGuide_map')
  endif
  if g:spacevim_vim_help_language ==# 'cn'
    let &helplang = 'cn'
  elseif g:spacevim_vim_help_language ==# 'ja'
    let &helplang = 'jp'
  endif
  ""
  " generate tags for SpaceVim
  let help = fnamemodify(g:_spacevim_root_dir, ':p:h:h') . '/doc'
  try
    exe 'helptags ' . help
  catch
    call SpaceVim#logger#warn('Failed to generate helptags for SpaceVim')
  endtry

  ""
  " set language
  if !empty(g:spacevim_language)
    silent exec 'lan ' . g:spacevim_language
  endif

  if SpaceVim#layers#isLoaded('core#statusline')
    call SpaceVim#layers#core#statusline#init()
  endif

  if !g:spacevim_relativenumber
    set norelativenumber
  else
    set relativenumber
  endif

  " tab options:
  set smarttab
  let &expandtab = g:spacevim_expand_tab
  let &tabstop = g:spacevim_default_indent
  let &softtabstop = g:spacevim_default_indent
  let &shiftwidth = g:spacevim_default_indent


  if g:spacevim_realtime_leader_guide
    nnoremap <silent><nowait> <leader> :<c-u>LeaderGuide get(g:, 'mapleader', '\')<CR>
    vnoremap <silent> <leader> :<c-u>LeaderGuideVisual get(g:, 'mapleader', '\')<CR>
  endif
  let g:leaderGuide_max_size = 15
  call SpaceVim#plugins#load()

  call SpaceVim#plugins#projectmanager#RootchandgeCallback()

  call SpaceVim#utils#source_rc('general.vim')



  call SpaceVim#autocmds#init()

  if has('nvim')
    call SpaceVim#utils#source_rc('neovim.vim')
  endif

  call SpaceVim#utils#source_rc('commands.vim')
  filetype plugin indent on
  syntax on
endfunction


" TODO
command -nargs=1 LeaderGuide call SpaceVim#mapping#guide#start_by_prefix('0', <args>)
command -range -nargs=1 LeaderGuideVisual call SpaceVim#mapping#guide#start_by_prefix('1', <args>)


