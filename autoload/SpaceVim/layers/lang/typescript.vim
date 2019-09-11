" --------------------------------------
" lang#typescript layer
" --------------------------------------


function! SpaceVim#layers#lang#typescript#plugins() abort
  let plugins = [
        \ ['leafgarland/typescript-vim'],
        \ ]
  if !SpaceVim#layers#lsp#check_filetype('typescript')
    if has('nvim')
      " Warn: this may slow down your nvim or even your machine
      "call add(plugins, ['mhartington/nvim-typescript', {'build': './install.sh'}])
    else
      call add(plugins, ['Quramy/tsuquyomi'])
    endif
  endif
  return plugins
endfunction


function! SpaceVim#layers#lang#typescript#config() abort
  augroup format
    au!
    " automatic comment insertion
    autocmd FileType typescript setlocal formatoptions+=cro
  augroup END

  if !has('nvim') && !SpaceVim#layers#lsp#check_filetype('typescript')
    augroup SpaceVim_lang_typescript
      autocmd!
      autocmd FileType typescript setlocal omnifunc=tsuquyomi#complete
    augroup END
  endif
  call SpaceVim#mapping#gd#add('typescript',
        \ function('s:go_to_def'))
  call SpaceVim#mapping#space#regesit_lang_mappings('typescript',
        \ function('s:on_ft'))
endfunction

function! SpaceVim#layers#lang#typescript#set_variable(var) abort
  if has('nvim')
    let  g:nvim_typescript#server_path =
          \ get(a:var, 'typescript_server_path',
          \ './node_modules/.bin/tsserver')
  else
    let tsserver_path = get(a:var, 'typescript_server_path', '')
    if !empty(tsserver_path)
      let g:tsuquyomi_use_dev_node_module = 2
      let g:tsuquyomi_tsserver_path = tsserver_path
    endif
  endif
endfunction

function! s:on_ft() abort
  if SpaceVim#layers#lsp#check_filetype('typescript')
    nnoremap <silent><buffer> K :call SpaceVim#lsp#show_doc()<CR>

    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'd'],
          \ 'call SpaceVim#lsp#show_doc()', 'show_document', 1)
    call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'e'],
          \ 'call SpaceVim#lsp#rename()', 'rename symbol', 1)
  else
    if has('nvim')
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'c'], 'TSTypeDef',
            \ 'type definition', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'd'], 'TsDoc',
            \ 'show document', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'e'], 'TSRename',
            \ 'rename symbol', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'f'], 'TSGetCodeFix',
            \ 'code fix', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'i'], 'TSImport',
            \ 'import', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'p'], 'TSDefPreview',
            \ 'preview definition', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'r'], 'TSRefs',
            \ 'references', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 's'], 'TSSearch <C-R><C-W> *<CR>',
            \ 'search', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 't'], 'TSType',
            \ 'view type', 1)
    else
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'c'], 'TsuTypeDefinition',
            \ 'type definition', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'd'], 'TsuquyomiSignatureHelp',
            \ 'show document', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'e'], 'TsuquyomiRenameSymbol',
            \ 'rename symbol', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'i'], 'TsuImport',
            \ 'import', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'm'], 'TsuImplementation',
            \ 'interface implementations', 1)
      call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'r'], 'TsuquyomiReferences',
            \ 'references', 1)
    endif
  endif
endfunction

function! s:go_to_def() abort
  if !SpaceVim#layers#lsp#check_filetype('typescript')
    if has('nvim')
      TSDef
    else
      call SpaceVim#lsp#go_to_def()
    endif
  else
    call SpaceVim#lsp#go_to_def()
  endif
endfunction
