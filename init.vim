" compat
set encoding=utf8
scriptencoding utf-8
set fileencoding=utf8
set fileformat=unix
set ff=unix


let g:isWindows = has('win16') || has('win32') || has('win64')
if g:isWindows
	let g:file_separator = '\\'
else
	let g:file_separator = '/'
endif

let g:modules = 'modules' . g:file_separator

function! LoadCustomModule(name)
	let l:script = g:modules . a:name . '.vim'
	execute ':runtime ' . l:script
endfunction

" Fix for snippets
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let g:isMac = 1
  else
    let g:isMac = 0
  endif
endif

" Load custom modules
call LoadCustomModule('core')
call LoadCustomModule('bindings')
call LoadCustomModule('ui')

" Commands
command! -nargs=+ -complete=dir SearchProject execute 'silent! grep!'.<q-args>
command! -nargs=1 -complete=buffer Bs :call tools#BufSel("<args>")

" Init packager
command! PackagerInstall call tools#PackagerInit() | call packager#install()
command! -bang PackagerUpdate call tools#PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call tools#PackagerInit() | call packager#clean()
command! PackagerStatus call tools#PackagerInit() | call packager#status()

" Set up plugin configurations
let g:netrw_localrmdir = 'rm -r' " use this command to remove folder
let g:gutentags_cache_dir = '~/.cache/'
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#no_mappings = 1
let g:mucomplete#buffer_relative_paths = 1
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['incl','omni','tags', 'c-p', 'defs', 'c-n', 'keyn', 'keyp', 'file', 'path', 'ulti']
let g:mucomplete#minimum_prefix_length = 2
let g:UltiSnipsSnippetsDir = $MYVIMRC . g:file_separator . 'UltiSnips'
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:matchup_matchparen_deferred = 1
let g:matchup_match_paren_timeout = 100
let g:matchup_matchparen_stopline = 200
let g:gutentags_project_root = ['package.json']
let g:colorizer_auto_filetype='css,html,javascript.jsx'
let g:vimwiki_nested_syntaxes = {'py': 'python','js': 'javascript', 'rs': 'rust', 'ts': 'typescript'}
let g:startify_session_persistence = 1
let g:startify_session_dir = '~/sessions'
let g:startify_session_sort = 1
let g:startify_change_to_dir = 0
let g:startify_bookmarks = [{ 'c': $MYVIMRC }]
let g:startify_lists = [
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_virtual_text_cursor = 1
let g:sessionPath = '~'.g:file_separator.'sessions'.g:file_separator

command! Scratch call tools#makeScratch()
execute ':color slick'
