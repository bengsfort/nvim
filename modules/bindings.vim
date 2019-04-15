scriptencoding = utf-8

let g:mapleader="\<Space>"
inoremap jj <Esc>

if exists(':tnoremap')
  tnoremap <C-\> <C-\><C-n>
endif

xnoremap <silent> p p:if v:register == '*'<Bar>let @@=@0<Bar>endif<cr>
xmap <up>    <Plug>SchleppUp
xmap <down>  <Plug>SchleppDown
xmap <left>  <Plug>SchleppLeft
xmap <right> <Plug>SchleppRight

" switching between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nnoremap ,d :bp<bar>bd #<CR>
nnoremap gh :call tools#ShowDeclaration(1)<CR>
nnoremap <silent>gj :call tools#PreviewWord()<CR>

nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>
nnoremap <silent> [q :cnext<CR>
nnoremap <silent> ]q :cprev<CR>
nnoremap <leader>sp :SearchProject<space>
nnoremap , :find<space>
nnoremap <leader>, :tselect<space>
nnoremap <leader>. :Bs<space>

" Source sessions
nnoremap <leader>os :call tools#sourceSession()<CR>

" Open up tagbar
nnoremap <F8> :TagbarToggle<CR>

" Search
nnoremap S :%s//g<LEFT><LEFT>
vmap s :s//g<LEFT><LEFT>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-t> :Tags<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

augroup FileNav
  autocmd!
  autocmd FileType dirvish nnoremap <buffer> <silent>D :call tools#DeleteFile()<CR>
  autocmd FileType dirvish nnoremap <buffer> n :e %/
  autocmd FileType dirvish nnoremap <buffer> r :call tools#RenameFile()<CR>
augroup END

" Allow for jumping when doing things like ls and :g/search/#
cnoremap <expr> <CR> tools#CCR()

function! OpenTerminalDrawer() abort
  execute 'copen'
  execute 'term'
endfunction

nnoremap <silent><leader>> :call OpenTerminalDrawer()<CR>i

" VimDev: {{{
function! Profiler() abort
  if exists('g:profiler_running')
    profile pause
    unlet g:profiler_running
    noautocmd qall!
  else
    let g:profiler_running = 1
    profile start profile.log
    profile func *
    profile file *
  endif
endfunction

nmap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
nmap <silent><F5> :so $MYVIMRC<CR>
nmap <silent><F7> :so %<CR>
nmap <silent><F1> :call Profiler()<CR>
" }}}
