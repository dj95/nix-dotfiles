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
local set = vim.o
local twilight = require "twilight"

twilight.setup({
  dimming = {
    alpha = 0.25,
    color = { "Normal", "#ffffff" },
    inactive = false,
  },
  context = 10,
  treesitter = true,
  expand = {
    "function",
    "method",
    "table",
    "if_statement",
  },
})

vim.api.nvim_create_autocmd({ 'InsertEnter' },
  {
    pattern = '*',
    callback = function()
      twilight.enable()
      set.relativenumber = false
    end
  }
)

vim.api.nvim_create_autocmd({ 'InsertLeave' },
  {
    pattern = '*',
    callback = function()
      twilight.disable()
      set.relativenumber = true
    end
  }
)
