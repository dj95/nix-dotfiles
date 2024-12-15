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
-- Section: languages
-- Author: Daniel Jankowski
-- Date: 25.09.2021
--

-- load all relevant modules that are language relevant
require "config.languages.autopair"
require "config.languages.cmp"
require "config.languages.formatter"
require "config.languages.inline-diagnostic"
require "config.languages.linter"
require "config.languages.lsp"
require "config.languages.lspsaga"
require "config.languages.markview"
require "config.languages.trouble"
require "config.languages.treesitter"


local set = vim.opt

-- To ignore plugin indent changes, instead use:
vim.cmd [[
  filetype plugin indent on
]]

-- if hidden is not set, TextEdit might fail.
set.hidden = true

-- Better display for messages
set.cmdheight = 0

-- You will have bad experience for diagnostic messages when it's default 4000.
set.updatetime = 300

-- don't give |ins-completion-menu| messages.
set.shortmess:append('c')

-- always show signcolumns
set.signcolumn = 'yes'
