" Load all bundles.
call pathogen#runtime_append_all_bundles()

" Mandatory stuff, just in case.
filetype on
filetype plugin on
filetype indent on
set backspace=indent,eol,start

" If the VIM client supports colors.
if has("gui_running") || &t_Co > 2
  syntax on
  colorscheme twilight

  set guifont=DejaVu\ Sans\ Mono\ 9

  " Hide the toolbar, the menu and the left scrollbar.
  set guioptions+=Tml
  set guioptions-=Tml

  " Show TextMate-like invisibles.
  set list
  set listchars=tab:▸\ ,eol:¬
endif

" Language-specific options.
if has("autocmd")
  " A single tab with the width of 4 spaces.
  autocmd FileType c,cpp setlocal softtabstop=0 shiftwidth=4 tabstop=4 noexpandtab
  autocmd FileType js setlocal shiftwidth=4 tabstop=4
endif

" VI → VIM compatibility.
set nocompatible

" Preferred indentation level for scripting languages.
set shiftwidth=2 tabstop=2 expandtab

" Turn on automatic indentation.
set autoindent cindent smartindent

" Show line-numbers.
set number

" Get rid of those tideous swapfiles.
set noswapfile nobackup

" Show all tab-complete suggestions.
set wildmode=list:longest

" Turn off case sensivity and turn on smart case searching.
set ignorecase smartcase

" Highlight search terms (even dynamically).
set hlsearch incsearch

" Shorten the “press ENTER to …” message.
set shortmess=atI

" Turn off the audio bell and turn on the visual bell.
set visualbell

" Turn off word-wrapping.
set nowrap

" Turn off search highlighting with \n.
nmap <silent> <leader>n :silent :nohlsearch<CR>

" Toggle TextMate-invisibles with \l.
nmap <silent> <leader>l :set list!<CR>

" Hit shift-tab to insert a hard tab.
imap <silent> <S-tab> <C-v><tab>

" Hit \p to preview a markdown file.
map <leader>p :Mm<CR>
