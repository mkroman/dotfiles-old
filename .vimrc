set nocompatible
filetype off
colorscheme xoria256
call pathogen#runtime_append_all_bundles()
set number
set tabstop=2                                                        
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set backspace=2
set showcmd
set showmatch
set ignorecase
set directory=~/.vim/swap
set backupdir=~/.vim/backup
set list
filetype plugin indent on


set listchars=tab:▸\ ,eol:¬
autocmd FileType c,cpp setlocal softtabstop=0 shiftwidth=4 tabstop=4 noexpandtab

syntax on

highlight NonText ctermfg=238

nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y 
