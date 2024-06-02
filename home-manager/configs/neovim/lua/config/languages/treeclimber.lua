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

local vim = vim
local treeclimber = require('nvim-treeclimber')

treeclimber.setup()

vim.keymap.set({ "n", "x", "o" }, "˙", treeclimber.select_backward, { desc = "select previous node" })
vim.keymap.set({ "n", "x", "o" }, "∆", treeclimber.select_shrink, { desc = "select previous node" })
vim.keymap.set({ "n", "x", "o" }, "˚", treeclimber.select_expand, { desc = "select previous node" })
vim.keymap.set({ "n", "x", "o" }, "˚¬", treeclimber.select_forward, { desc = "select previous node" })

