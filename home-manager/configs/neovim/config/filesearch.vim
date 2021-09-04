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
" Section: filesearch
" Author: Daniel Jankowski
" Date: 22.08.2019
"


" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS='--prompt=":: " --layout=reverse --margin=1,2 --color fg:15,bg:235,hl:10,fg+:15,bg+:235,hl+:12 --color info:8,prompt:10,pointer:10,marker:10,spinner:8'

" find hidden files as well
let $FZF_DEFAULT_COMMAND='rg --hidden -l "" 2>/dev/null'

" Using the custom window creation function
let g:fzf_layout = {
  \ 'window': 'call FloatingFZF()',
  \ }

" make the colors do not look that ugly
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'SpellBad'],
  \ 'hl':      ['fg', 'Statement'],
  \ 'fg+':     ['fg', 'CursorLine'],
  \ 'bg+':     ['fg', 'CursorLine',],
  \ 'hl+':     ['fg', 'Identifier'],
  \ 'gutter':  ['bg', 'SpellBad'],
  \ 'info':    ['fg', 'LineNr'],
  \ 'border':  ['fg', 'Normal'],
  \ 'prompt':  ['fg', 'PreProc'],
  \ 'pointer': ['fg', 'PreProc'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'LineNr'],
  \ 'header':  ['fg', 'SpellBad']
  \ }

" Files + devicons
function! Fzf_files_with_dev_icons(command)
  let l:fzf_files_options = $FZF_DEFAULT_OPTS
    \ .' --prompt=":: " --preview "bat --color always --style numbers {2..} | head -'.&lines.'"'

  function! s:edit_devicon_prepended_file(item)
    let l:file_path = a:item[4:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
    \ 'source': a:command.' | devicon-lookup',
    \ 'sink': function('s:edit_devicon_prepended_file'),
    \ 'options': l:fzf_files_options,
    \ 'window': 'call FloatingFZF()',
    \ })
endfunction

" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)

  " 90% of the height
  let height = float2nr(&lines * 0.75)
  " 60% of the height
  let width = float2nr(&columns * 0.6)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (one line down of the top)
  let vertical = float2nr(&lines * 0.125)

  let opts = {
        \ 'relative': 'editor',
        \ 'row'     : vertical,
        \ 'col'     : horizontal,
        \ 'width'   : width,
        \ 'height'  : height,
        \ 'style'   : 'minimal'
        \ }

  " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction

" fuzzy filesearch command with fzf and ripgrep
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,yml,j2,java}"
  \ -g "!{.git,node_modules,vendor}/*" 2>/dev/null '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, {'options': '--prompt=":: "'},<bang>0)

" Telescope config
lua << EOF
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
}

require'telescope'.load_extension'z'
require'telescope'.load_extension'emoji'
EOF
