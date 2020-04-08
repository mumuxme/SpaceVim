" --------------------------------------
" lang#python layer
"
" to make this layer work well, you should install jedi.
" --------------------------------------

let s:is_enable_lsp = SpaceVim#layers#lsp#check_filetype('python')
let s:go_to_def = { -> s:is_enable_lsp ? SpaceVim#lsp#go_to_def() : jedi#goto() }


function! SpaceVim#layers#lang#python#plugins() abort
  let plugins = [
        \ ['heavenshell/vim-pydocstring', { 'on_cmd': 'Pydocstring' }],
        \ ['Vimjas/vim-python-pep8-indent', { 'on_ft': 'python' }],
        \ ['vim-python/python-syntax', { 'on_ft': 'python' }],
        \ ]

  if !s:is_enable_lsp
    if has('nvim')
      call add(plugins, ['deoplete-plugins/deoplete-jedi', { 'on_ft' : 'python'}])
      " in neovim, we can use deoplete-jedi together with jedi-vim,
      " but we need to disable the completions of jedi-vim.
      let g:jedi#completions_enabled = 0
    endif
    call add(plugins, ['davidhalter/jedi-vim', { 'on_ft' : 'python',
          \ 'if' : has('python') || has('python3')}])
  endif

  return plugins
endfunction


function! SpaceVim#layers#lang#python#config() abort
  call s:python_syntax_config()
  call s:pydocstring_config()

  call SpaceVim#plugins#runner#reg_runner('python',
        \ {
        \ 'exe' : function('s:getexe'),
        \ 'opt' : [],
        \ })
  call SpaceVim#mapping#gd#add('python', s:go_to_def)
  call SpaceVim#mapping#space#regesit_lang_mappings('python', function('s:language_specified_mappings'))
  if executable('ipython')
    call SpaceVim#plugins#repl#reg('python', 'ipython --no-term-title')
  elseif executable('python')
    call SpaceVim#plugins#repl#reg('python', 'python')
  endif
endfunction

" --------------------------------------

function! s:python_syntax_config() abort
  " https://github.com/vim-python/python-syntax
  let g:python_version_2 = 0
  let g:python_highlight_builtin_funcs = 1
  let g:python_highlight_builtin_objs = 1
  let g:python_highlight_builtin_types = 1
  let g:python_highlight_exceptions = 1
  let g:python_highlight_string_formatting = 1
  let g:python_highlight_string_format = 1
  let g:python_highlight_string_templates = 1
  let g:python_highlight_indent_errors = 0
  let g:python_highlight_space_errors = 0
  let g:python_highlight_doctests = 1
  let g:python_highlight_class_vars = 1
  let g:python_highlight_operators = 0
  let g:python_highlight_file_headers_as_comments = 0
endfunction


function! s:pydocstring_config() abort
  " heavenshell/vim-pydocstring

  " If you execute :Pydocstring at no `def`, `class` line.
  " g:pydocstring_enable_comment enable to put comment.txt value.
  let g:pydocstring_enable_comment = 0

  " Disable this option to prevent pydocstring from creating any
  " key mapping to the `:Pydocstring` command.
  " Note: this value is overridden if you explicitly create a
  " mapping in your vimrc, such as if you do:
  let g:pydocstring_enable_mapping = 0
endfunction


function! s:language_specified_mappings() abort
  call SpaceVim#mapping#space#langSPC('nmap', ['l','r'],
        \ 'call SpaceVim#plugins#runner#open()',
        \ 'execute current file', 1)
  let g:_spacevim_mappings_space.l.i = {'name' : '+Imports'}
  call SpaceVim#mapping#space#langSPC('nmap', ['l','i', 's'],
        \ 'Neoformat isort',
        \ 'sort imports', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','i', 'r'],
        \ 'Neoformat autoflake',
        \ 'remove unused imports', 1)
  let g:_spacevim_mappings_space.l.s = {'name' : '+Send'}
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'i'],
        \ 'call SpaceVim#plugins#repl#start("python")',
        \ 'start REPL process', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'l'],
        \ 'call SpaceVim#plugins#repl#send("line")',
        \ 'send line and keep code buffer focused', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'b'],
        \ 'call SpaceVim#plugins#repl#send("buffer")',
        \ 'send buffer and keep code buffer focused', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 's'],
        \ 'call SpaceVim#plugins#repl#send("selection")',
        \ 'send selection and keep code buffer focused', 1)

  " +Generate {{{

  let g:_spacevim_mappings_space.l.g = {'name' : '+Generate'}

  call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'g', 'd'],
        \ 'Pydocstring', 'generate docstring', 1)

  " }}}

  if SpaceVim#layers#lsp#check_filetype('python')
    nnoremap <silent><buffer> K :call SpaceVim#lsp#show_doc()<CR>

    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'd'],
          \ 'call SpaceVim#lsp#show_doc()', 'show_document', 1)
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'e'],
          \ 'call SpaceVim#lsp#rename()', 'rename symbol', 1)
  endif
endfunction

func! s:getexe() abort
  let line = getline(1)
  if line =~# '^#!'
    let exe = split(line)
    let exe[0] = exe[0][2:]
    return exe
  endif
  return ['python']
endf
