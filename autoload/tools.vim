function! tools#PackagerInit() abort
    packadd vim-packager
    call packager#init()
    call packager#add('tpope/vim-commentary')
    call packager#add('tpope/vim-repeat')
    call packager#add('romainl/vim-cool')
    call packager#add('romainl/vim-qf')
    call packager#add('justinmk/vim-dirvish')
    call packager#add('thinca/vim-localrc')
    call packager#add('mhinz/vim-startify')
    call packager#add('tmsvg/pear-tree')

    call packager#add('chemzqm/vim-jsx-improve', { 'type': 'opt' })
    call packager#add('rktjmp/git-info.vim')
    call packager#add('chrisbra/Colorizer', { 'type': 'opt' })
    call packager#add('andymass/vim-matchup', { 'type': 'opt' })
    call packager#add('leafgarland/typescript-vim', { 'type': 'opt' })
    call packager#add('peitalin/vim-jsx-typescript', { 'type': 'opt' })
    call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
    call packager#add('vimwiki/vimwiki', { 'type': 'opt' })
    call packager#add('w0rp/ale', { 'type': 'opt' })
    call packager#add('SirVer/ultisnips', { 'type': 'opt' })
    call packager#add('jamestthompson3/vim-better-javascript-completion', { 'type': 'opt' })
    call packager#add('iamcco/markdown-preview.nvim', { 'type': 'opt', 'do': 'cd app && yarn install' })
    call packager#add('tpope/vim-fugitive', { 'type': 'opt' })
    call packager#add('ludovicchabant/vim-gutentags', { 'type': 'opt' })
    call packager#add('elzr/vim-json', { 'type': 'opt' })
    call packager#add('lifepillar/vim-mucomplete', { 'type': 'opt' })
    call packager#add('sheerun/vim-polyglot', { 'type': 'opt' })
    call packager#add('racer-rust/vim-racer', { 'type': 'opt' })
    call packager#add('reasonml-editor/vim-reason-plus', { 'type': 'opt' })
    call packager#add('zirrostig/vim-schlepp', { 'type': 'opt' })
    call packager#add('tpope/vim-scriptease', { 'type': 'opt' })
    call packager#add('tpope/vim-speeddating', { 'type': 'opt' })
    call packager#add('tpope/vim-surround', { 'type': 'opt' })
  endfunction

function! tools#loadDeps() abort
  if exists('g:loadedDeps')
    return
  else
    packadd ale
    packadd vim-polyglot
    packadd vim-fugitive
    packadd vim-gutentags
    packadd vim-matchup
    packadd vim-schlepp
    packadd vim-surround
    packadd vim-mucomplete
    let g:loadedDeps = 1
  endif
endfunction

" allows for easy jumping using commands like ili, ls, dli, etc.
function! tools#CCR()
    let cmdline = getcmdline()
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction

function! tools#makeScratch() abort
  execute 'new'
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction

function! tools#ShowDeclaration(global) abort
    let pos = getpos('.')
    if searchdecl(expand('<cword>'), a:global) == 0
        let line_of_declaration = line('.')
        execute line_of_declaration . '#'
    endif
    call cursor(pos[1], pos[2])
endfunction

function! tools#PreviewWord() abort
  if &previewwindow            " don't do this in the preview window
    return
  endif
  let w = expand('<cword>')        " get the word under cursor
  if w =~ '\a'            " if the word contains a letter

    " Delete any existing highlight before showing another tag
    silent! wincmd P            " jump to preview window
    if &previewwindow            " if we really get there...
      match none            " delete existing highlight
      wincmd p            " back to old window
    endif

    " Try displaying a matching tag for the word under the cursor
    try
        exe 'ptag ' . w
    catch
      return
    endtry

    silent! wincmd P            " jump to preview window
    if &previewwindow        " if we really get there...
    if has('folding')
      silent! .foldopen        " don't want a closed fold
    endif
    call search('$', 'b')        " to end of previous line
    let w = substitute(w, '\\', '\\\\', '')
    call search('\<\V' . w . '\>')    " position cursor on match
    " Add a match highlight to the word at this position
      hi previewWord term=bold ctermbg=green guibg=green
    exe 'match previewWord "\%' . line('.') . 'l\%' . col('.') . 'c\k*"'
      wincmd p            " back to old window
    endif
  endif
endfunction
