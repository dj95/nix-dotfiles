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
local auto_dark_mode = require('auto-dark-mode')

-- vim.g.catppuccin_flavour = "mocha"
vim.o.termguicolors = true

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
		vim.cmd('colorscheme catppuccin-mocha')
		vim.cmd('colorscheme catppuccin-mocha')
	end,
	set_light_mode = function()
		vim.api.nvim_set_option('background', 'dark')
		vim.cmd('colorscheme catppuccin-mocha')
		vim.cmd('colorscheme catppuccin-mocha')
		-- vim.api.nvim_set_option('background', 'light')
		-- vim.cmd('colorscheme onelight')
		-- vim.cmd('colorscheme onelight')
	end,
})


