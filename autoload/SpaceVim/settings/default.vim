" Default SpaceVim settings
scriptencoding utf-8

""
" Version of SpaceVim , this value can not be changed.
let g:spacevim_version = '1.0.0'
lockvar g:spacevim_version

""
" @section default_indent, options-default_indent
" @parentsection options
" Change the default indentation of SpaceVim. Default is 2.
" >
"   default_indent = 2
" <

""
" Change the default indentation of SpaceVim. Default is 2.
" >
"   let g:spacevim_default_indent = 2
" <
let g:spacevim_default_indent          = 2
""
" In Insert mode: Use the appropriate number of spaces to insert a <Tab>
let g:spacevim_expand_tab              = 1

""
" @section relativenumber, options-relativenumber
" @parentsection options
" Enable/Disable relativenumber, by default it is enabled.
" >
"   relativenumber = true
" <

""
" Enable/Disable relativenumber, by default it is enabled.
let g:spacevim_relativenumber          = 1

""
" @section max_column, options-max_column
" @parentsection options
" Change the max number of columns for SpaceVim. Default is 120.
" >
"   max_column = 120
" <

""
" Change the max number of columns for SpaceVim. Default is 120.
" >
"   let g:spacevim_max_column = 120
" <
let g:spacevim_max_column              = 120

""
" @section enable_guicolors, options-enable_guicolors
" @parentsection options
" Enable true color support in terminal. Default is true.
" >
"   enable_guicolors = true
" <

""
" Enable true color support in terminal. Default is 1.
" >
"   let g:spacevim_enable_guicolors = 1
" <
let g:spacevim_enable_guicolors = 1

""
" @section enable_googlesuggest, options-enable_googlesuggest
" @parentsection options
" Enable/Disable Google suggestions for neocomplete. Default is false.
" >
"   enable_googlesuggest = false
" <

""
" Enable/Disable Google suggestions for neocomplete. Default is 0.
" >
"   let g:spacevim_enable_googlesuggest = 1
" <
let g:spacevim_enable_googlesuggest    = 0

""
" @section windows_leader, options-windows_leader
" @parentsection options
" Window functions leader for SpaceVim. Default is `s`.
" Set to empty to disable this feature, or you can set to another char.
" >
"   windows_leader = ""
" <


""
" Window functions leader for SpaceVim. Default is `s`.
" Set to empty to disable this feature, or you can set to another char.
" >
"   let g:spacevim_windows_leader = ''
" <
let g:spacevim_windows_leader          = 's'

""
" @section enable_insert_leader, options-enable_insert_leader
" @parentsection options
" Enable/Disable spacevim's insert mode leader, default is enable

""
" Enable/Disable spacevim's insert mode leader, default is enable
let g:spacevim_enable_insert_leader    = 1

""
" @section plugin_bundle_dir, options-plugin_bundle_dir
" @parentsection options
" Set the cache directory of plugins. Default is `~/.cache/vimfiles`.
" >
"   plugin_bundle_dir = "~/.cache/vimplugs"
" <

""
" Set the cache directory of plugins. Default is `~/.cache/vimfiles`.
" >
"   let g:spacevim_plugin_bundle_dir = '~/.cache/vimplugs'
" <
let g:spacevim_plugin_bundle_dir
      \ = $HOME. join(['', '.cache', 'vimfiles', ''],
      \ SpaceVim#api#import('file').separator)

""
" @section realtime_leader_guide, options-realtime_leader_guide
" @parentsection options
" Enable/Disable realtime leader guide. Default is true. to disable it:
" >
"   realtime_leader_guide = false
" <

""
" Enable/Disable realtime leader guide. Default is 1. to disable it:
" >
"   let g:spacevim_realtime_leader_guide = 0
" <
let g:spacevim_realtime_leader_guide   = 1
""
" Enable/Disable key frequency catching of SpaceVim. default value is 0. to
" enable it:
" >
"   let g:spacevim_enable_key_frequency = 1
" <
let g:spacevim_enable_key_frequency = 0
if (has('python3') && SpaceVim#util#haspy3lib('neovim')) &&
      \ (has('nvim') || (has('patch-8.0.0027')))
  ""
  " Set the autocomplete engine of spacevim, the default logic is:
  " >
  "   if has('python3')
  "     let g:spacevim_autocomplete_method = 'deoplete'
  "   elseif has('lua')
  "     let g:spacevim_autocomplete_method = 'neocomplete'
  "   elseif has('python')
  "     let g:spacevim_autocomplete_method = 'completor'
  "   elseif has('timers')
  "     let g:spacevim_autocomplete_method = 'asyncomplete'
  "   else
  "     let g:spacevim_autocomplete_method = 'neocomplcache'
  "   endif
  " <
  "
  " and you can alse set this option to coc, then coc.nvim will be useed.
  let g:spacevim_autocomplete_method = 'deoplete'
elseif has('lua')
  let g:spacevim_autocomplete_method = 'neocomplete'
elseif has('python') && ((has('job') && has('timers') && has('lambda')) || has('nvim'))
  let g:spacevim_autocomplete_method = 'completor'
elseif has('timers')
  let g:spacevim_autocomplete_method = 'asyncomplete'
else
  let g:spacevim_autocomplete_method = 'neocomplcache'
endif

""
" @section enable_neomake, options-enable_neomake
" @parentsection options
" SpaceVim default checker is neomake. If you want to use syntastic, use:
" >
"   enable_neomake = false
" <

""
" SpaceVim default checker is neomake. If you want to use syntastic, use:
" >
"   let g:spacevim_enable_neomake = 0
" <
let g:spacevim_enable_neomake          = 1

""
" @section enable_ale, options-enable_ale
" @parentsection options
" Use ale for syntax checking, disabled by default.
" >
"   enable_ale = true
" <

""
" Use ale for syntax checking, disabled by default.
" >
"   let g:spacevim_enable_ale = 1
" <
let g:spacevim_enable_ale          = 0

""
" @section guifont, options-guifont
" @parentsection options
" Set the guifont of SpaceVim. Default is empty.
" >
"   guifont = "SauceCodePro Nerd Font Mono:h11"
" <

""
" Set the guifont of SpaceVim. Default is empty.
" >
"   let g:spacevim_guifont = "SauceCodePro Nerd Font Mono:h11"
" <
let g:spacevim_guifont                 = ''

""
" @section enable_ycm, options-enable_ycm
" @parentsection options
" Enable/Disable YouCompleteMe. Default is false.
" >
"   enable_ycm = true
" <

""
" Enable/Disable YouCompleteMe. Default is 0.
" >
"   let g:spacevim_enable_ycm = 1
" <
let g:spacevim_enable_ycm              = 0

""
" @section sidebar_width, options-sidebar_width
" @parentsection options
" Set the width of the SpaceVim sidebar. Default is 30.
" This value will be used by tagbar and vimfiler.

""
" Set the width of the SpaceVim sidebar. Default is 30.
" This value will be used by tagbar and vimfiler.
let g:spacevim_sidebar_width           = 30

""
" @section snippet_engine, options-snippet_engine
" @parentsection options
" Set the snippet engine of SpaceVim, default is neosnippet. to enable
" ultisnips:
" >
"   snippet_engine = "ultisnips"
" <

""
" Set the snippet engine of SpaceVim, default is neosnippet. to enable
" ultisnips:
" >
"   let g:spacevim_snippet_engine = "ultisnips"
" <
let g:spacevim_snippet_engine = 'neosnippet'
let g:spacevim_enable_neocomplcache    = 0
""
" Enable/Disable cursorline. Default is 1, cursorline will be
" highlighted in normal mode.To disable this feature:
" >
"   let g:spacevim_enable_cursorline = 0
" <
let g:spacevim_enable_cursorline       = 1
""
" Set the statusline separators of statusline, default is 'arrow'
" >
"   Separators options:
"     1. arrow
"     2. curve
"     3. slant
"     4. nil
"     5. fire
" <
"
" See more details in: http://spacevim.org/documentation/#statusline
"
let g:spacevim_statusline_separator = 'arrow'
let g:spacevim_statusline_inactive_separator = 'arrow'

""
" Define the left section of statusline in active windows. By default:
" >
"   let g:spacevim_statusline_left_sections =
"     \ [
"     \ 'winnr',
"     \ 'filename',
"     \ 'major mode',
"     \ 'minor mode lighters',
"     \ 'version control info'
"     \ ]
" <
let g:spacevim_statusline_left_sections = ['winnr', 'filename', 'major mode',
      \ 'syntax checking', 'minor mode lighters',
      \ ]
""
" Define the right section of statusline in active windows. By default:
" >
"   g:spacevim_statusline_right_sections =
"     \ [
"     \ 'fileformat',
"     \ 'cursorpos',
"     \ 'percentage'
"     \ ]
" <
let g:spacevim_statusline_right_sections = ['fileformat', 'cursorpos', 'percentage']

""
" Enable/Disable unicode symbols in statusline
let g:spacevim_statusline_unicode_symbols = 1
""
" Enable/Disable language specific leader, by default you can use `,` ket
" instead of `SPC` `l`.
let g:spacevim_enable_language_specific_leader = 1

""
" @section enable_statusline_mode, options-enable_statusline_mode
" @parentsection options
" Enable/Disable display mode. Default is 0, mode will be
" displayed in statusline. To enable this feature:
" >
"   enable_statusline_mode = true
" <

""
" Enable/Disable display mode. Default is 0, mode will be
" displayed in statusline. To enable this feature:
" >
"   let g:spacevim_enable_statusline_mode = 1
" <
let g:spacevim_enable_statusline_mode     = 0
""
" Set the statusline/tabline palette of color, default values depends on the theme
" >
"   let g:spacevim_custom_color_palette = [
"     \ ['#282828', '#b8bb26', 246, 235],
"     \ ['#a89984', '#504945', 239, 246],
"     \ ['#a89984', '#3c3836', 237, 246],
"     \ ['#665c54', 241],
"     \ ['#282828', '#83a598', 235, 109],
"     \ ['#282828', '#fe8019', 235, 208],
"     \ ['#282828', '#8ec07c', 235, 108],
"     \ ['#282828', '#689d6a', 235, 72],
"     \ ['#282828', '#8f3f71', 235, 132],
"     \ ]
" <
"
let g:spacevim_custom_color_palette = []
""
" Enable/Disable cursorcolumn. Default is 0, cursorcolumn will be
" highlighted in normal mode. To enable this feature:
" >
"   let g:spacevim_enable_cursorcolumn = 1
" <
let g:spacevim_enable_cursorcolumn     = 0

""
" @section error_symbol, options-error_symbol
" @parentsection options
" Set the error symbol for SpaceVim's syntax maker. Default is '✖'.
" >
"   error_symbol = "+"
" <

""
" Set the error symbol for SpaceVim's syntax maker. Default is '✖'.
" >
"   let g:spacevim_error_symbol = '+'
" <
let g:spacevim_error_symbol            = '✖'
""
" Set the warning symbol for SpaceVim's syntax maker. Default is '⚠'.
" >
"   let g:spacevim_warning_symbol = '!'
" <
let g:spacevim_warning_symbol          = '⚠'
""
" Set the information symbol for SpaceVim's syntax maker. Default is '🛈'.
" >
"   let g:spacevim_info_symbol = 'i'
" <
let g:spacevim_info_symbol             = SpaceVim#api#import('messletters').circled_letter('i')
""
" Set the SpaceVim cursor shape in the terminal.
" >
"   0 : to prevent Nvim from changing the cursor shape.
"   1 : to enable non-blinking mode-sensitive cursor.
"   2 : to enable blinking mode-sensitive cursor (default).
" >
" Host terminal must support the DECSCUSR CSI escape sequence.
" Depending on the terminal emulator, using this option with nvim under
" tmux might require adding the following to ~/.tmux.conf:
" >
"   set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
" <
let g:spacevim_terminal_cursor_shape = 2
""
" Set the help language of vim. Default is 'en'.
" You can change it to Chinese.
" >
"   let g:spacevim_vim_help_language = 'cn'
" <
let g:spacevim_vim_help_language       = 'en'
""
" Set the message language of vim. Default is 'en_US.UTF-8'.
" >
"   let g:spacevim_language = 'en_CA.utf8'
" <
let g:spacevim_language                = ''
""
" Option for keep the spacevim server ailive
let g:spacevim_keep_server_alive = 1
""
" The colorscheme of SpaceVim. Default is 'gruvbox'.
let g:spacevim_colorscheme             = 'gruvbox'
""
" The background of colorscheme. Default is 'dark'.
let g:spacevim_colorscheme_bg             = 'dark'
""
" The default colorscheme of SpaceVim. Default is 'desert'.
" This colorscheme will be used if the colorscheme set by
" `g:spacevim_colorscheme` is not installed.
" >
"   let g:spacevim_colorscheme_default = 'other_color'
" <
let g:spacevim_colorscheme_default     = 'desert'
""
" Enable/disable simple mode of SpaceVim. Default is 0.
" In this mode, only few plugins will be installed.
" >
"   let g:spacevim_simple_mode = 1
" <
let g:spacevim_simple_mode             = 0
""
" The default file manager of SpaceVim. Default is 'vimfiler'.
let g:spacevim_filemanager             = 'vimfiler'

let g:spacevim_sidebar_direction        = ''
""
" The default plugin manager of SpaceVim.
" if has patch 7.4.2071, the default value is dein. Otherwise it is neobundle.
" Options are dein, neobundle, or vim-plug.
if has('patch-7.4.2071')
  let g:spacevim_plugin_manager          = 'dein'
else
  let g:spacevim_plugin_manager          = 'neobundle'
endif

""
" @section plugin_manager_processes, options-plugin_manager_processes
" @parentsection options
" Set the max process of SpaceVim plugin manager

""
" Set the max process of SpaceVim plugin manager
let g:spacevim_plugin_manager_processes = 16

""
" @section checkinstall, options-checkinstall
" @parentsection options
" Enable/Disable checkinstall on SpaceVim startup. Default is true.
" >
"   checkinstall = true
" <

""
" Enable/Disable checkinstall on SpaceVim startup. Default is 1.
" >
"   let g:spacevim_checkinstall = 1
" <
let g:spacevim_checkinstall            = 1
""
" Enable/Disable vimcompatible mode, by default it is disabled. In
" vimcompatible mode all vim origin key bindings will not be changed.
"
" Includes:
" >
"   q       smart quit windows
"   s       windows key bindings leader
"   <C-x>   switch buffer
" <
let g:spacevim_vimcompatible           = 0
""
" Enable/Disable debug mode for SpaceVim. Default is 0.
" >
"   let g:spacevim_enable_debug = 1
" <
let g:spacevim_enable_debug            = 0
""
" Auto disable touchpad when switch to insert mode or focuslost in neovim.
let g:spacevim_auto_disable_touchpad   = 1
""
" TODO
" Set the debug level of SpaceVim. Default is 1. see
" |SpaceVim#logger#setLevel()|
"let g:spacevim_debug_level             = 1
let g:spacevim_hiddenfileinfo          = 1
let g:spacevim_gitcommit_pr_icon       = ''
let g:spacevim_gitcommit_issue_icon    = ''
""
" Set SpaceVim buffer index type, default is 0.
" >
"   " types:
"   " 0: 1 ➛ ➊
"   " 1: 1 ➛ ➀
"   " 2: 1 ➛ ⓵
"   " 3: 1 ➛ ¹
"   " 4: 1 ➛ 1
"   let g:spacevim_buffer_index_type = 1
" <
let g:spacevim_buffer_index_type = 0
""
" Set SpaceVim windows index type, default is 0.
" >
"   " types:
"   " 0: 1 ➛ ➊
"   " 1: 1 ➛ ➀
"   " 2: 1 ➛ ⓵
"   " 3: 1 ➛ 1
"   let g:spacevim_windows_index_type = 1
" <
let g:spacevim_windows_index_type = 0
""
" Enable/Disable tabline filetype icon. default is 0.
let g:spacevim_enable_tabline_filetype_icon = 0
""
" Enable/Disable os fileformat icon. default is 0.
let g:spacevim_enable_os_fileformat_icon = 0
""
" Set the github username, It will be used for getting your starred repos, and
" fuzzy find the repo you want.
let g:spacevim_github_username         = ''
""
" Set the default key for smart close windows, default is `q`.
let g:spacevim_windows_smartclose      = 'q'
""
" Disable plugins by name.
" >
"   let g:spacevim_disabled_plugins = ['vim-foo', 'vim-bar']
" <
let g:spacevim_disabled_plugins        = []
""
" Add custom plugins.
" >
"   let g:spacevim_custom_plugins = [
"               \ ['plasticboy/vim-markdown', 'on_ft' : 'markdown'],
"               \ ['wsdjeg/GitHub.vim'],
"               \ ]
" <
let g:spacevim_custom_plugins          = []
""
" change the default filetype icon for a specific filtype.
" >
"   let g:spacevim_filetype_icons['md'] = ''
" <
let g:spacevim_filetype_icons           = {}
""
" SpaceVim will load the global config after local config if set to 1. Default
" is 0. If you have a local config, the global config will not be loaded.
" >
"   let g:spacevim_force_global_config = 1
" <
let g:spacevim_force_global_config     = 0
""
" Enable/Disable powerline symbols. Default is 1.
let g:spacevim_enable_powerline_fonts  = 1
""
" Enable/Disable lint on save feature of SpaceVim's maker. Default is 1.
" >
"   let g:spacevim_lint_on_save = 0
" <
let g:spacevim_lint_on_save            = 1
""
" Default search tools supported by flygrep. The default order is ['rg', 'ag',
" 'pt', 'ack', 'grep', 'findstr']
let g:spacevim_search_tools            = ['rg', 'ag', 'pt', 'ack', 'grep', 'findstr']
""
" Set the project rooter patterns, by default it is
" `['.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']`
let g:spacevim_project_rooter_patterns = ['.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
""
" Enable/Disable changing directory automatically. Enabled by default.
let g:spacevim_project_rooter_automatically = 1

""
" Config the command line prompt for flygrep and denite etc.
let g:spacevim_commandline_prompt = '➭'

""
" @section lint_on_the_fly, options-lint_on_the_fly
" @parentsection options
" Enable/Disable lint on the fly feature of SpaceVim's maker. Default is true.
" >
"   lint_on_the_fly = false
" <

""
" Enable/Disable lint on the fly feature of SpaceVim's maker. Default is 0.
" >
"   let g:spacevim_lint_on_the_fly = 0
" <
let g:spacevim_lint_on_the_fly         = 0
""
" Enable/Disable vimfiler in the welcome windows. Default is 1.
" This will cause vim to start up slowly if there are too many files in the
" current directory.
" >
"   let g:spacevim_enable_vimfiler_welcome = 0
" <
let g:spacevim_enable_vimfiler_welcome = 1
""
" Enable/Disable gitstatus column in vimfiler buffer, default is 0.
let g:spacevim_enable_vimfiler_gitstatus = 0
""
" Enable/Disable filetypeicon column in vimfiler buffer, default is 0.
let g:spacevim_enable_vimfiler_filetypeicon = 0
""
" Enable/Disable autocompletion of parentheses, default is 1 (enabled).
let g:spacevim_autocomplete_parentheses = 1
let g:spacevim_autocomplete_parens = 1    " TODO: remove
let g:spacevim_smartcloseignorewin     = ['__Tagbar__' , 'vimfiler:default']
let g:spacevim_smartcloseignoreft      = [
      \ 'tagbar',
      \ 'vimfiler',
      \ 'SpaceVimRunner',
      \ 'SpaceVimREPL',
      \ 'SpaceVimQuickFix',
      \ 'HelpDescribe',
      \ 'VebuggerShell',
      \ 'VebuggerTerminal',
      \ 'SpaceVimTabsManager'
      \ ]
let g:_spacevim_altmoveignoreft         = ['Tagbar' , 'vimfiler']
let g:spacevim_enable_javacomplete2_py = 0
let g:spacevim_src_root                = 'E:\sources\'
""
" The host file url. This option is for Chinese users who can not use
" Google and Twitter.
let g:spacevim_hosts_url
      \ = 'https://raw.githubusercontent.com/racaljk/hosts/master/hosts'
let g:spacevim_wildignore
      \ = '*.so,*.swp,*.zip,*.class,tags,*.jpg,
      \*.ttf,*.TTF,*.png,*/target/*,
      \.git,.svn,.hg,.DS_Store,*.svg'

" --------------------------------------

" Private SpaceVim options
let g:_spacevim_mappings = {}
let g:_spacevim_mappings_space_custom = []
let g:_spacevim_mappings_space_custom_group_name = []
let g:_spacevim_neobundle_installed     = 0
let g:_spacevim_dein_installed          = 0
let g:_spacevim_vim_plug_installed      = 0

if !exists('g:leaderGuide_vertical')
  let g:leaderGuide_vertical = 0
endif

let g:spacevim_leader_guide_vertical = 0

if !exists('g:leaderGuide_sort_horizontal')
  let g:leaderGuide_sort_horizontal = 0
endif

let g:spacevim_leader_guide_sort_horizontal = 0

if !exists('g:leaderGuide_position')
  let g:leaderGuide_position = 'botright'
endif

let g:spacevim_leader_guide_position = 'botright'

if !exists('g:leaderGuide_run_map_on_popup')
  let g:leaderGuide_run_map_on_popup = 1
endif

let g:spacevim_leader_guide_run_map_on_popup = 1

if !exists('g:leaderGuide_hspace')
  let g:leaderGuide_hspace = 5
endif

let g:spacevim_leader_guide_hspace = 5

if !exists('g:leaderGuide_flatten')
  let g:leaderGuide_flatten = 1
endif

let g:spacevim_leader_guide_flatten = 1

if !exists('g:leaderGuide_default_group_name')
  let g:leaderGuide_default_group_name = ''
endif

let g:spacevim_leader_guide_default_group_name = ''

if !exists('g:leaderGuide_max_size')
  let g:leaderGuide_max_size = 0
endif

let g:spacevim_leader_guide_max_size = 0

if !exists('g:leaderGuide_submode_mappings')
  let g:leaderGuide_submode_mappings =
        \ { '<C-C>': 'win_close', 'n': 'page_down', 'p': 'page_up', 'u' : 'undo'}
endif

let g:spacevim_leader_guide_submode_mappings = {'<C-C>': 'win_close'}

" SpaceVim/LanguageClient-neovim {{{
if !exists('g:LanguageClient_serverCommands')
  let g:LanguageClient_serverCommands = {}
endif
" }}}
