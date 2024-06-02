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
-- Date: 07.07.2022
--

local neotest = require('neotest')
local neotest_vim_test = require('neotest-vim-test')
local neotest_phpunit = require('neotest-phpunit')
local plenary = require('plenary')

-- vim-test
vim.cmd [[
  let test#strategy = "neovim"
  " let test#php#phpunit#options = '--testdox'
]]

neotest.setup({
  adapters = {
    neotest_vim_test({
      ignore_file_types = { "python", "vim", "lua" },
    }),
    neotest_phpunit,
  }
})
