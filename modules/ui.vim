scriptencoding = utf-8

colorscheme tokyo-metro
set termguicolors	" update gui colors
set cursorline	" show the cursor line
set relativenumber	" use relative line numbers
set list

set listchars= " list chars for showing indentation
set listchars+=tab:░\
set listchars+=trail:·
set listchars+=space:·
set listchars+=extends:»
set listchars+=precedes:«
" set listchars+=nbsp:⣿<Paste>

function! MyHighlights() abort
  " Custom higlight groups
  hi SpellBad guibg=#ff2929 ctermbg=196
  hi! link NormalNC Comment
  hi! link Whitespace Comment
  hi! link IsNotModified StatusLine
  hi! link StatusLineModified Todo
endfunction

augroup Colors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" Tabline: {{{
set showtabline=2
set tabline=ᚴ\ %{statusline#StatuslineGit()}\ %{statusline#GitChanges()}
" }}}

" Statusline
set statusline=
set statusline+=%<
set statusline+=%#StatusLineModified#%{&mod?expand('%'):''}%*%#IsNotModified#%{&mod?'':expand('%')}%*
" set statusline+=\ %{statusline#StatuslineGit()}
" set statusline+=\ %{statusline#GitChanges()}

set statusline+=%=
set statusline+=\ %{statusline#ReadOnly()}
set statusline+=\ %{statusline#LinterStatus()}

" vim compat
if !has('nvim')
  set renderoptions=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
  set background=dark
  set incsearch
  set hlsearch
  set laststatus=2
endif
