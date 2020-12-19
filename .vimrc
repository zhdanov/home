hi Visual cterm=reverse
hi Visual ctermbg=NONE

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indentation
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Misc
set nopaste
set nocompatible
filetype plugin on

" begin set paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
" end set paste
