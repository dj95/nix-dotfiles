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
" Section: plugins
" Author: Daniel Jankowski
" Date: 22.08.2019
"

" set the runtime path to include Vundle and initialize it
call plug#begin('~/.vim/plugged')

    "
    " General plugins
    "

    " add the matching paranthesis, bracket, brace...
    " Plug 'tpope/vim-surround'
    " Plug 'jiangmiao/auto-pairs'
    " Plug 'tpope/vim-fugitive'
    Plug 'arzg/vim-colors-xcode'
    
    " move visual blocks
    " Plug 'matze/vim-move'

    " markdown rendering
    Plug 'shime/vim-livedown'

    " go development
    " Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " fuzzy file search
    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'junegunn/fzf.vim'
    Plug 'xiyaowong/telescope-emoji.nvim'

    "
    " snippets
    " Plug 'SirVer/ultisnips'
    " Plug 'honza/vim-snippets'

    " Note taking
    " Plug 'xolox/vim-notes'
    " Plug 'xolox/vim-misc'

    " MySQL integration
    " Plug 'kezhenxu94/vim-mysql-plugin'
 
    "
    " Visuals
    "

    " airline support and tagbar
    " Plug 'bling/vim-airline'
    Plug 'dj95/vim-airline-themes'
    " Plug 'majutsushi/tagbar'
    Plug 'akinsho/bufferline.nvim'

    " highlight indents
    " Plug 'yggdroot/indentline'

    " file browser
    " Plug 'scrooloose/nerdtree'
    " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " Plug 'ryanoasis/vim-devicons'

    " different syntax highlightnings
    Plug 'chr4/nginx.vim'
    Plug 'etdev/vim-hexcolor'

    " display git status
    " Plug 'airblade/vim-gitgutter'

    " zoom into one split like in tmux
    " Plug 'troydm/zoomwintab.vim'
    Plug 'akinsho/bufferline.nvim'

    "
    " Autocompletion
    "

    " install the completion engine
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'folke/lsp-colors.nvim'

" All of your Plugins must be added before the following line
call plug#end()
