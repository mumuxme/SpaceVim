""
" api-system
""
scriptencoding utf-8

" Information about your system
"
" keys:
"   'isWindows' :: Bool,
"   'isLinux' :: Bool,
"   'isOSX' :: Bool,
"   'isDarwin' :: Bool,
"   'Fsep' :: String,
"   'Psep' :: String,
"   'name' :: String,
"   'systemicon' :: String,
"
" deprecated keys:
"   'fileformat' :: Function (use 'systemicon' instead)
let s:system = {}

let s:system['isWindows'] = has('win16') || has('win32') || has('win64')
let s:system['isLinux'] = has('unix') && !has('macunix') && !has('win32unix')
let s:system['isOSX'] = has('macunix')

" for SpaceVim#api#import
function! SpaceVim#api#system#get() abort
  return deepcopy(s:system)
endfunction

" --------------------------------------

function! s:fsep() abort
  if s:system.isWindows
    return '\'
  else
    return '/'
  endif
endfunction

let s:system['Fsep'] = s:fsep()


function! s:psep() abort
  if s:system.isWindows
    return ';'
  else
    return ':'
  endif
endfunction

let s:system['Psep'] = s:psep()


function! s:name() abort
  if s:system.isLinux
    return 'linux'
  elseif s:system.isWindows
    if has('win32unix')
      return 'cygwin'
    else
      return 'windows'
    endif
  else
    return 'mac'
  endif
endfunction

let s:system['name'] = s:name()


function! s:isDarwin() abort
  if exists('s:is_darwin')
    return s:is_darwin
  endif

  if has('macunix')
    let s:is_darwin = 1
    return s:is_darwin
  endif

  if ! has('unix')
    let s:is_darwin = 0
    return s:is_darwin
  endif

  if system('uname -s') ==# "Darwin\n"
    let s:is_darwin = 1
  else
    let s:is_darwin = 0
  endif

  return s:is_darwin
endfunction

let s:system['isDarwin'] = s:isDarwin()


function! s:systemicon() abort
  let icon = ''
  if &fileformat ==? 'dos'
    let icon = ''
  elseif &fileformat ==? 'unix'
    if s:isDarwin()
      let icon = ''
    else
      let icon = ''
    endif
  elseif &fileformat ==? 'mac'
    let icon = ''
  endif

  return icon
endfunction

let s:system['systemicon'] = s:systemicon()
let s:system['fileformat'] = function('s:systemicon')
