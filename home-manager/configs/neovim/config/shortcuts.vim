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
" Section: shortcuts
" Author: Daniel Jankowski
" Date: 22.08.2019
"

"
" General
"

" configure the leader key
nnoremap <SPACE> <Nop>
let mapleader = " "

" toggle helpful sidebars
map <C-h> :NvimTreeToggle<CR>
map <C-l> :TagbarToggle<CR>

" easy buffer navigation
nmap <C-j> :bp<CR>
nmap <C-k> :bn<CR>

" fuzzy searches
nmap <leader>sp <cmd>lua require('telescope.builtin').live_grep()<cr>
nmap <leader><SPACE> <cmd>lua require('telescope.builtin').find_files()<cr>
nmap <leader>gL <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nmap <leader>bb <cmd>lua require('telescope.builtin').buffers()<cr>
nmap <leader>e :Telescope emoji search<cr>
nmap <leader>cx :TroubleToggle<cr>

" window splitting
nnoremap <C-w>\| :vsplit<CR>
nnoremap <C-w>- :split<CR>
nnoremap <C-w>z :ZoomWinTabToggle<CR>
nmap <leader>wv :vsplit<CR>
nmap <leader>wh :split<CR>
nmap <leader>wc :close<CR>

"
" Autocompletion
"

" Use leader h to show documentation in preview window
nnoremap <leader>ck <cmd>lua vim.lsp.buf.hover()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Remap keys for gotos
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent> gy <cmd>lua vim.lsp.buf.declaration()<CR>
nmap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nmap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

let g:coc_snippet_next = '<tab>'

"
" Learn things the hard way...
"

" force use of the home row
nnoremap <Up> :echomsg "use k"<cr>
nnoremap <Down> :echomsg "use j"<cr>
nnoremap <Left> :echomsg "use h"<cr>
nnoremap <Right> :echomsg "use l"<cr>
