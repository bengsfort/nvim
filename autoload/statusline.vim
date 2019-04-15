scriptencoding utf-8

"   if !exists('g:loaded_ale')
"     return ' '
"   else
"     let l:counts = ale#statusline#Count(bufnr(''))
"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:warning = l:counts.warning
"     let l:error = l:counts.error
"     if l:all_errors + l:counts.warning == 0
"      return '✓'
"     else
"       return printf(
"     \   '%d W %d E',
"     \   l:warning,
"     \   l:error
"     \) . ' '
"     endif
"   endif
" endfunction

" function! statusline#ReadOnly() abort
"   if &readonly || !&modifiable
"     hi User3 guifg=#c9505c guibg=#191f26 gui=BOLD
"     if g:isWindows
"       return '-- RO --'
"     else
"       return ''
"     endif
"   else
"     return ''
"   endif
" endfunction

" function! statusline#GitBranch()
"   if g:isWindows
"     return trim(system("git rev-parse --abbrev-ref HEAD 2> NUL | tr -d '\n'"))
"   else
"     return trim(system("git rev-parse --abbrev-ref HEAD 2> /dev/null | tr -d '\n'"))
"   endif
" endfunction

" function! statusline#StatuslineGit()
"   let l:branchname = statusline#GitBranch()
"   return strlen(l:branchname) > 0?'  ['.l:branchname.'] ':''
" endfunction

" function! statusline#GitChanges()
"   let l:changesDict = git_info#changes()
"   return get(l:changesDict, 'changed').' changed ('.get(l:changesDict, 'untracked').' untracked) +'.get(l:changesDict, 'insertions').'/-'.get(l:changesDict, 'deletions')
" endfunction
