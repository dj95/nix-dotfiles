"        ___                       ___           ___           ___
"       /\__\          ___        /\__\         /\  \         /\  \
"      /:/  /         /\  \      /::|  |       /::\  \       /::\  \
"     /:/  /          \:\  \    /:|:|  |      /:/\:\  \     /:/\:\  \
"    /:/__/  ___      /::\__\  /:/|:|__|__   /::\~\:\  \   /:/  \:\  \
"    |:|  | /\__\  __/:/\/__/ /:/ |::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\
"    |:|  |/:/  / /\/:/  /    \/__/~~/:/  / \/_|::\/:/  / \:\  \  \/__/
"    |:|__/:/  /  \::/__/           /:/  /     |:|::/  /   \:\  \
"     \::::/__/    \:\__\          /:/  /      |:|\/__/     \:\  \
"      ~~~~         \/__/         /:/  /       |:|  |        \:\__\
"                                 \/__/         \|__|         \/__/
"
"
" Section: main
" Author: Daniel Jankowski
" Date: 22.08.2019
"

" configure indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" code folding
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=0

" persistent undo
set undodir=~/.vim/undodir
set undofile

" configure the cursor
set mouse=a
set cursorline
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" misc options
set t_Co=256
set encoding=utf8
set showcmd
set autoread
set ttyfast
set lazyredraw
set title
set noshowmode
set hidden
set secure

" dont wait that long when running in tmux to accept the escape key
set updatetime=500
set timeoutlen=1000 ttimeoutlen=10

" configure line numebers - relative in normal mode, absolute in insert mode
set number
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" set nvim specific options
if has('nvim')
    " configure the clipbard
    set clipboard=unnamed
    set clipboard+=unnamedplus
endif

" source config files
source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/shortcuts.vim
source ~/.config/nvim/config/autocomplete.vim
source ~/.config/nvim/config/filesearch.vim
source ~/.config/nvim/config/theme.light.vim
lua require('config.autocomplete')
lua require('config.theme')

"
" Autostart mechanisms
"

" Start NERDTree
autocmd VimEnter * if &filetype !=# 'gitcommit' && &filetype !=# 'vim' | NERDTreeToggle | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open tagbar for different filetypes
autocmd BufEnter *.go,*.php,*.py,*.sh,*.h,*.c,*.cpp,*.js,*.jsx,*.ts,*.tsx nested TagbarOpen

autocmd BufEnter * set shiftwidth=4
autocmd BufEnter *.yml,*.yaml,*.html,*.js,*.ts,*.jsx,*.tsx set shiftwidth=2 

" Jump to the main window.
autocmd VimEnter * wincmd p

" React syntax highlighting
autocmd bufnewfile,bufread *.tsx set filetype=typescript.tsx
autocmd bufnewfile,bufread *.jsx set filetype=javascript.jsx
