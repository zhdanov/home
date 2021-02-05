hi Visual cterm=reverse
hi Visual ctermbg=NONE

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" indentation
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" misc
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

" git blame for selected line
vnoremap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" cursor on last position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
