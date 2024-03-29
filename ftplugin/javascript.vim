scriptencoding = utf-8

setlocal suffixesadd=.js,.jsx,.ts,.tsx
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
setlocal define=class\\s
setlocal foldmethod=syntax
setlocal foldlevelstart=99
setlocal foldlevel=99
setlocal omnifunc=javascriptcomplete#CompleteJS

if !exists('g:loaded_js_config')
  packadd vim-better-javascript-completion
  packadd ultisnips
  packadd Colorizer
  packadd vim-jsx-improve

  let g:loaded_js_config = 1
endif

let g:mucomplete#chains.javascript = ['omni','keyn', 'keyp', 'c-p', 'c-n', 'tags', 'file','path', 'ulti']
let g:mucomplete#chains['javascript.jsx'] = ['omni','keyn', 'keyp', 'c-p', 'c-n', 'tags', 'file','path', 'ulti']

let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:vim_json_syntax_conceal = 0
" }}}

" ALE: {{{
let b:ale_linters = ['eslint']
let b:ale_fixers = ['prettier']
let b:ale_linters_ignore = ['tsserver']
" }}}

" Misc: {{{
let g:vimjs#casesensistive = 0
let g:vimjs#smartcomplete = 1
let g:vimjs#chromeapis = 1
let g:vimjs#reactapis = 1
" }}}
