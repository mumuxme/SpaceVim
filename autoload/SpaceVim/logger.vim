"""
" logger for SpaceVim
""
let s:LOGGER = SpaceVim#api#import('logging')

call s:LOGGER.set_name('SpaceVim')
call s:LOGGER.set_level("DEBUG")
call s:LOGGER.set_silent(1)

function! SpaceVim#logger#debug(msg, ...)
  call call(s:LOGGER.debug, [a:msg] + a:000)
endfunction

function! SpaceVim#logger#info(msg, ...)
  call call(s:LOGGER.info, [a:msg] + a:000)
endfunction

function! SpaceVim#logger#warn(msg, ...)
  call call(s:LOGGER.warning, [a:msg] + a:000)
endfunction

function! SpaceVim#logger#error(msg, ...)
  call call(s:LOGGER.error, [a:msg] + a:000)
endfunction

function! SpaceVim#logger#viewRuntimeLog() abort
  call SpaceVim#api#logging#pprint(s:LOGGER)
endfunction


function! SpaceVim#logger#viewLog(...) abort
  let info = "<details><summary> SpaceVim debug information </summary>\n\n"
  let info .= "### SpaceVim options :\n\n"
  let info .= "```toml\n"
  let info .= join(SpaceVim#options#list(), "\n")
  let info .= "\n```\n"
  let info .= "\n\n"

  let info .= "### SpaceVim layers :\n\n"
  let info .= SpaceVim#layers#report()
  let info .= "\n\n"

  let info .= "### SpaceVim Health checking :\n\n"
  let info .= SpaceVim#health#report()
  let info .= "\n\n"

  let info .= "### SpaceVim runtime log :\n\n"
  let info .= "```log\n"

  let info .= s:LOGGER.view(s:LOGGER.level)

  let info .= "\n```\n</details>\n\n"
  if a:0 > 0
    if a:1 == 1
      tabnew +setl\ nobuflisted
      nnoremap <buffer><silent> q :bd!<CR>
      for msg in split(info, "\n")
        call append(line('$'), msg)
      endfor
      normal! "_dd
      setl nomodifiable
      setl buftype=nofile
      setl filetype=markdown
    else
      echo info
    endif
  else
    return info
  endif
endfunction

""
" @public
" Set debug level of SpaceVim. Default is `DEBUG`.
function! SpaceVim#logger#setLevel(level)
  call s:LOGGER.set_level(a:level)
endfunction

""
" @public
" Set the log output file of SpaceVim. Default is empty.
function! SpaceVim#logger#setOutput(file) abort
  call s:LOGGER.set_file(a:file)
endfunction
