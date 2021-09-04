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
" Section: theme
" Author: Daniel Jankowski
" Date: 22.08.2019
"

" colorscheme
set termguicolors
" set background=dark
colorscheme xcodedark
highlight! Normal guibg=NONE ctermbg=NONE
highlight! NonText guibg=NONE ctermbg=NONE

" theme the search highlights
set hlsearch
hi Search ctermbg=LightYellow
hi Search ctermfg=black

" mark chars over 80 characters red
highlight OverLength ctermbg=LightYellow ctermfg=black guibg=#592929
match OverLength /\%81v.\+/

" indentline configuration
let g:indentLine_char = '│'
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 'inc'
let g:indentLine_setConceal = 0

let g:tex_conceal='abdmg'
set conceallevel=2

" Statusbar
set laststatus=2

" airline configuration
let g:airline_powerline_fonts = 1
let g:airline_theme = 'retro'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '


" theme gitgutter
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'

" colors for gitgutter
highlight GitGutterAdd    guifg=#b0e687 guibg=None ctermfg=10 ctermbg=None
highlight GitGutterChange guifg=#ffa14f guibg=None ctermfg=LightYellow ctermbg=None
highlight GitGutterDelete guifg=#ff8170 guibg=None ctermfg=1 ctermbg=None

" confiure icons
let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

" NERDTree configuration
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1

" nvimtree colors
hi NvimTreeNormal guibg=#212126
hi NvimTreeEndOfBuffer guibg=#212126 guifg=#212126
hi NvimTreeVertStatusLineNC guibg=#212126
hi NvimTreeVertSplit guibg=#212126 guifg=#212126
