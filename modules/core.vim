scriptencoding utf-8


syntax enable
set hidden " show hidden buffers
filetype plugin indent on
set title
set lazyredraw
set autoread	" reread file if edited from elsewhere
set splitright	" Automatically set cursor to the right
set undolevels=1000
set wildignorecase
set magic	" extended regex
" set mouse=nv	" mouse can be used in both visual and normal modes
set wildmode=list:longest,full	" extended tab completion

" 2 spaces = 1 tab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround	" consistent tabs
set ignorecase	" ignore cases when searching
set smartcase	" ignore case unless you have a cap letter in your search case
set undofile
set backup
set swapfile
set synmaxcol=180
set grepprg=rg\ --vimgrep	" use ripgrep in vim mode
set completeopt+=longest,noinsert,menuone,noselect
set completeopt-=preview
set complete-=t
set omnifunc=syntaxcomplete#Complete
set path-=/usr/include
set path+=**

" auto correct my dumb errors
iabbrev retrun return
iabbrev rerun return
iabbrev improt import
iabbrev imprt import

augroup core
  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
    \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
  autocmd BufWritePre * %s/\s\+$//e " remove whitespace
  au! BufNewFile,BufRead *.tsx setf typescript.tsx
  au! BufNewFile,BufRead *.eslintrc,*.babelrc,*.prettierrc,*.huskyrc setf json
  au! BufNewFile,BufRead *.bat,*.sys setf dosbatch
	autocmd BufAdd * call tools#loadDeps()
	autocmd SessionLoadPost * call tools#loadDeps()
  autocmd WinNew * call tools#saveSession()
  autocmd VimLeavePre * call tools#saveSession()
augroup END

augroup MarkMargin
  autocmd!
  autocmd BufEnter * :call MarkMargin()
augroup END

function! MarkMargin()
  if exists('b:MarkMargin')
    call matchadd('ErrorMsg', '\%>'.b:MarkMargin.'v\s*\zs\$', 0)
  endif
endfunction

if has('nvim')
  set inccommand=split " previews search
endif

" Backup dirs
let g:data_dir = $HOME . '/.cache/Vim/'
let g:backup_dir = g:data_dir . 'backup'
let g:swap_dir = g:data_dir . 'swap'
let g:undo_dir = g:data_dir . 'undofile'
let g:conf_dir = g:data_dir . 'conf'
if finddir(g:data_dir) ==# ''
  silent call mkdir(g:data_dir, 'p', 0700)
endif
if finddir(g:backup_dir) ==# ''
  silent call mkdir(g:backup_dir, 'p', 0700)
endif
if finddir(g:swap_dir) ==# ''
  silent call mkdir(g:swap_dir, 'p', 0700)
endif
if finddir(g:undo_dir) ==# ''
  silent call mkdir(g:undo_dir, 'p', 0700)
endif
if finddir(g:conf_dir) ==# ''
  silent call mkdir(g:conf_dir, 'p', 0700)
endif
unlet g:data_dir
unlet g:backup_dir
unlet g:swap_dir
unlet g:undo_dir
unlet g:conf_dir
set undodir=$HOME/.cache/Vim/undofile
set backupdir=$HOME/.cache/Vim/backup
set directory=$HOME/.cache/Vim/swap<Paste>

" ignore shit
set wildignore+=*/dist*/*,*/target/*,*/builds/*,*/pack/*
" Ignore libs
set wildignore+=*/lib/*,*/node_modules/*,*/bower_components/*,*/locale/*,*/flow-typed/*
" Ignore images, pdfs, and font files
set wildignore+=*.png,*.PNG,*.jpg,*.jpeg,*.JPG,*.JPEG,*.pdf
set wildignore+=*.ttf,*.otf,*.woff,*.woff2,*.eot

let g:loaded_python_provider = 1
if g:isWindows
  let g:python3_host_prog = 'C:\Users\matt.bengston\AppData\Local\Programs\Python\Python36-32\python.exe'
elseif g:isMac
  let g:python3_host_prog= '/usr/local/bin/python3'
else
  let g:python3_host_prog = '/usr/bin/python3'
endif

augroup AutoSwap
  autocmd!
  autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

function! AS_HandleSwapfile (filename, swapname)
 " if swapfile is older than file itself, just get rid of it
  if getftime(v:swapname) < getftime(a:filename)
    call delete(v:swapname)
    let v:swapchoice = 'e'
  endif
endfunction

function! s:myTodo()
  syn match Todo '@\?\(todo\|fixme\):\?' containedin=.*Comment,vimCommentTitle contained
  hi link MyTodo Todo
endfunction

" Syntax improvements
augroup vimrc_todo
    au!
    au Syntax * call s:myTodo()
augroup END
