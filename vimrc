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
ino " ""<left>
ino ' ''<left>
ino ( ()<left>
ino [ []<left>
ino { {}<left>
imap kj <Esc>
:set relativenumber
:highlight LineNr ctermfg=grey
:set clipboard=unnamedplus
execute pathogen#infect()
filetype plugin indent on
