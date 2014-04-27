execute pathogen#infect()

" Let's have a gigantic history - we have the memory for it!
set history=1000

" Enable filetype plugins
if has("autocmd")
  filetype plugin indent on
endif 
" Set the minimal number of lines displayed above and below the current line
set scrolloff=5

" Syntax highlighting and coloring
if &t_Co > 2 || has("gui_running")
	syntax on
endif

let g:jellybeans_background_color=""

" 256-color support
if &t_Co >= 256 || has("gui_running")
	colorscheme jellybeans
else
" (╯°□°）╯︵ ┻━┻
endif

" Default to unix file format
set fileformat=unix

" Splits open on the right side
set splitright

" Scripting indentation levels
set expandtab shiftwidth=2 tabstop=2

" Enable tab-completion
set wildmode=list:longest

" Ignore common file types
set wildignore+=*.so,*.zip,*.pdf,*.a,*.swp,.git,.svn,Build,*.3

" Enable the wildmenu
set wildmenu

" Change the leader key
let mapleader = ","

" Turn off case sensivity and turn on smart case searching
set ignorecase smartcase

" Highlight search terms (even dynamically)
set hlsearch incsearch

" Shorten the “press ENTER to …” message
set shortmess=atI

" Turn off the audio bell and turn on the visual bell
set visualbell

" Turn on automatic indentation
set autoindent smartindent

" Turn off word-wrapping
set nowrap

" Turn on line numbers
set number

" Enable cursor-line highlighting
set cursorline

" Hide buffers instead of prompting an error when changing from a modified
" file to another one.
"set hidden

" Enable TextMate-style invisibles
set list listchars=tab:▸\ ,eol:¬

" Don't write swap-files or backup files
set noswapfile nobackup

" For pasting large amounts of text
set pastetoggle=<F2>

" Show the status line
set laststatus=2

" Enable folding
set foldenable foldmethod=manual foldmarker={{{,}}}

" Print solid (unicode) lines for vertical splits
set fillchars=vert:\│

" Set an 78-character margin
set colorcolumn=80

" Non-obnoxious wrapping
set textwidth=80 formatoptions=cq wrapmargin=0

" Return to last editing position
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif "

" {{{ Key Mappings

" Shortcut for command-mode
nnoremap ; :

" Press \ + / to clear search
nmap <silent> <leader>/ :nohlsearch<CR>

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" Jump 10 lines at a time
nmap <S-j> 10j
nmap <S-k> 10k

" Open git diff in a split view
command! GdiffInTab tabedit %|vsplit|Gdiff
nnoremap <leader>d :GdiffInTab<cr>
nnoremap <leader>D :tabclose<cr>

" Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Moving between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

" Managing tabs
map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>
map <leader>to :tabonly<CR>
map <leader>tm :tabmove

" Split vertically
nnoremap <leader>s :vnew<CR>
nnoremap <leader>\ :vnew<CR>

" Split horizontally
nnoremap <leader>- :new<CR>

" Quick save
map <leader>w :w!<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

" Edit vim file
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" Reload vim file
nnoremap <leader>sv :source $MYVIMRC<CR>

" Open alternate spec/implementation file
function! OpenAlternateFile()
  let new_file = alternate#FindAlternate()

  if new_file != 0
    exec ':e ' . new_file
  endif
endfunction

nnoremap <leader>a :call OpenAlternateFile()<CR>

" Airline configuration.

" Use patched powerline font symbols.
let g:airline_powerline_fonts = 1

" Language-specific settings.
autocmd FileType c,cpp setlocal shiftwidth=4 softtabstop=4 noexpandtab
