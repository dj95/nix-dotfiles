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
set background=dark
" colorscheme smyck
colorscheme github
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

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
highlight GitGutterAdd    guifg=#009900 guibg=None ctermfg=10 ctermbg=None
highlight GitGutterChange guifg=#bbbb00 guibg=None ctermfg=LightYellow ctermbg=None
highlight GitGutterDelete guifg=#ff2222 guibg=None ctermfg=1 ctermbg=None

" confiure icons
let g:WebDevIconsOS = 'Linux'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

" NERDTree configuration
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
