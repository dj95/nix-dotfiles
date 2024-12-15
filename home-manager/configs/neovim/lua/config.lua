--        ___                       ___           ___           ___
--       /\__\          ___        /\__\         /\  \         /\  \
--      /:/  /         /\  \      /::|  |       /::\  \       /::\  \
--     /:/  /          \:\  \    /:|:|  |      /:/\:\  \     /:/\:\  \
--    /:/__/  ___      /::\__\  /:/|:|__|__   /::\~\:\  \   /:/  \:\  \
--    |:|  | /\__\  __/:/\/__/ /:/ |::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\
--    |:|  |/:/  / /\/:/  /    \/__/~~/:/  / \/_|::\/:/  / \:\  \  \/__/
--    |:|__/:/  /  \::/__/           /:/  /     |:|::/  /   \:\  \
--     \::::/__/    \:\__\          /:/  /      |:|\/__/     \:\  \
--      ~~~~         \/__/         /:/  /       |:|  |        \:\__\
--                                 \/__/         \|__|         \/__/
--
--
-- Section: theme
-- Author: Daniel Jankowski
-- Date: 25.09.2021
--

local vim = vim
local set = vim.opt

-- configure indentation
set.autoindent  = true
set.smartindent = true
set.smarttab    = true
set.tabstop     = 4
set.shiftwidth  = 4
set.expandtab   = true

-- shell / fishs git integration is sloooooow
set.shell = '/bin/sh'

-- persistent undo
set.undofile = true

-- configure the cursor
set.mouse      = 'nv'
set.cursorline = true
set.guicursor  = 'n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor'

-- live substitution
set.inccommand = 'nosplit'

-- misc options
set.encoding     = 'utf8'
set.autoread     = true
set.title        = true
set.hidden       = true
set.secure       = true
set.magic        = true
set.virtualedit  = "block"
set.history      = 2000
set.conceallevel = 2
set.showcmd      = false
set.showmode     = false
set.ruler        = false

-- redraw
set.lazyredraw = true
set.redrawtime = 1000
set.termsync   = true

-- dont wait that long when running in tmux to accept the escape key
set.updatetime  = 500
set.timeout     = true
set.timeoutlen  = 1000
set.ttimeout    = true
set.ttimeoutlen = 10

-- configure line numbers - relative in normal mode, absolute in insert mode
set.number         = true
set.relativenumber = true

-- show trailing whitespaces
set.list = true
set.listchars = {
  trail = '·',
  tab = '  '
}
set.fillchars = {
  fold = ' ',
  foldclose = '▸',
  foldopen = '▾',
  eob = ' ',
  diff = '╱'
}

-- configure the clipboard
set.clipboard = "unnamedplus"

-- require the main modules
require('config.theme')
require('config.general')
require('config.languages')
require('config.shortcuts')
