hi Visual cterm=reverse
hi Visual ctermbg=NONE

colorscheme solarized

" navigation
set scrolloff=8

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
nnoremap <S-> >>
nnoremap <S-< <gv

" misc
set nopaste
set nocompatible
filetype plugin on

" no .swp files
set nobackup
set noswapfile

let mapleader = " "

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

" git blame for selected lines (visal mode)
" select lines and press \ + b
vnoremap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" save
nmap <leader>w :w<cr>

" cursor on last position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" remove last spaces in the line
autocmd BufWritePre *.{bash,php,js,css} :%s/\s\+$//e

" search down into subfolders
" provides tab-completion for all file-related tasks
" :find
set path+=**

" display all matching files when we tab complete
set wildmenu

" cursor (insert/command mode)
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" colors
set t_Co=256
let g:solarized_termcolors=256

" toggle paste
set pastetoggle=<F1>

" numbers
set relativenumber
nnoremap <F2> :set invrelativenumber<CR>
