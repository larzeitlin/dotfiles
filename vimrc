set nocompatible
filetype off
set encoding=utf-8
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch
syntax on
set mouse=a
syntax enable
set laststatus=2
set expandtab
ino " ""<left>
ino ' ''<left>
ino ( ()<left>
ino [ []<left>
ino { {}<left>
imap kj <Esc>
:set relativenumber
set clipboard=unnamedplus
execute pathogen#infect()
filetype plugin indent on
nnoremap <C-p> :Files<Cr>
map <C-r> :Rg<cr>
nnoremap <C-t> :below terminal<CR>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>
