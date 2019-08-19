""
" Simple logging module
""

let s:logger = {
      \ 'name' : '',
      \ 'silent' : 1,
      \ 'level' : 'NOTSET',
      \ 'file' : '',
      \ 'temp' : [],
      \ }

let s:levels = {
      \ 'ERROR': 40,
      \ 'WARNING': 30,
      \ 'INFO': 20,
      \ 'DEBUG': 10,
      \ 'NOTSET': 0,
      \ }

function! s:logger.set_silent(sl)
  let s:logger.silent = a:sl
endfunction

function! s:logger.set_level(l)
  let s:logger.level = a:l
endfunction

function! s:logger.set_name(name)
  let s:logger.name = a:name
endfunction

function! s:logger.set_file(file)
  let s:logger.file = a:file
endfunction

function! s:logger.get_name()
  return s:logger.name
endfunction

function! s:logger.write(msg) abort
  call add(s:logger.temp, a:msg)
  if empty(s:logger.file)
    return
  endif
  if !isdirectory(fnamemodify(s:logger.file, ':p:h'))
    call mkdir(expand(fnamemodify(s:logger.file, ':p:h')), 'p')
  endif
  let flags = filewritable(s:logger.file) ? 'a' : ''
  call writefile([a:msg], s:logger.file, flags)
endfunction

function! s:logger.show(level) abort
  let info = ''
  if filereadable(s:logger.file)
    let logs = readfile(s:logger.file, '')
    let info .= join(deepcopy(s:logger.temp), "\n")
  else
    let info .= '[ ' . s:logger.name . ' ] : logger file ' . s:logger.file
          \ . ' does not exists, only log for current process will be shown!'
    let info .= "\n"
    let info .= join(deepcopy(s:logger.temp), "\n")
  endif
  return info
endfunction

function! s:formatter(msg, level)
  let time = strftime('%H:%M:%S')
  let msg = type(a:msg) == type("") ? a:msg : string(a:msg)
  return '[ ' . s:logger.name . ' ] [' . time . '] [ ' . a:level . ' ] ' . msg
endfunction

" --------------------------------------

function! s:log_message(msg, level, kargs)
  " kargs is a dict which contains several options:
  "   {
  "     'silent' :: Bool,  -- temporary override predefined silent option.
  "   }
  if s:levels[s:logger.level] > s:levels[a:level]
    return
  endif

  let log = s:formatter(a:msg, a:level)
  let silent = get(a:kargs, 'silent', s:logger.silent)

  if !silent
    if a:level ==# 'WARNING'
      echohl WarningMsg
    elseif a:level ==# 'ERROR'
      echohl Error
    endif
    echom log
    if a:level ==# 'WARNING' || a:level ==# 'ERROR'
      echohl None
    endif
  endif

  call s:logger.write(log)
endfunction

function! s:logger.debug(msg, ...)
  call s:log_message(a:msg, 'DEBUG', a:0 > 0 ? a:1 : {})
endfunction

function! s:logger.info(msg, ...)
  call s:log_message(a:msg, 'INFO', a:0 > 0 ? a:1 : {})
endfunction

function! s:logger.warning(msg, ...)
  call s:log_message(a:msg, 'WARNING', a:0 > 0 ? a:1 : {})
endfunction

function! s:logger.error(msg, ...)
  call s:log_message(a:msg, 'ERROR', a:0 > 0 ? a:1 : {})
endfunction

" for import
function! SpaceVim#api#logging#get() abort
  return deepcopy(s:logger)
endfunction

" --------------------------------------

function! SpaceVim#api#logging#pprint(logger) abort
  let info = "## SpaceVim runtime log :\n\n"
  let info .= "```log\n"
  let info .= a:logger.show(a:logger.level)
  let info .= "\n```\n"

  tabnew +setl\ nobuflisted
  nnoremap <buffer><silent> q :bd!<CR>
  for msg in split(info, "\n")
    call append(line('$'), msg)
  endfor
  normal! "_dd
  setl nomodifiable
  setl buftype=nofile
  setl filetype=markdown
endfunction


" --------------------------------------
"  deprecated functions
" --------------------------------------

function! s:logger.warn(msg, ...)
  call call(s:logger.warning, [a:msg] + a:000)
endfunction

function! s:logger.view(level)
  call s:logger.show(level)
endfunction
