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

local gruvbox = require("gruvbox")

local bg = "#3c3836"

gruvbox.setup({
	undercurl = true,
	underline = true,
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = false, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	palette_overrides = {},
	overrides = {
		-- telescope
		TelescopeNormal = { bg = gruvbox.palette.dark1 },
		TelescopeResultsBorder = { bg = gruvbox.palette.dark1 },
		TelescopeResultsTitle = { bg = gruvbox.palette.dark1, fg = gruvbox.palette.dark1 },
		TelescopePreviewBorder = { bg = gruvbox.palette.dark1 },
		TelescopePrompt = { bg = gruvbox.palette.dark2 },
		TelescopePromptNormal = { bg = gruvbox.palette.dark2 },
		TelescopePromptPrefix = { bg = gruvbox.palette.dark2 },
		TelescopePromptBorder = { bg = gruvbox.palette.dark2 },
		TelescopePromptTitle = {
			bg = gruvbox.palette.dark2,
			fg = gruvbox.palette.light1,
			italic = true,
		},
		TelescopePreviewTitle = { bg = gruvbox.palette.dark1, fg = gruvbox.palette.dark1 },

		-- markview
		MarkviewCode = { bg = gruvbox.palette.dark1 },
		MarkviewCodeInfo = { bg = gruvbox.palette.dark1 },
		StatusLine = {
			bg = gruvbox.palette.dark0_hard,
			fg = gruvbox.palette.light1,
			reverse = false,
		},
		StatusLineNC = {
			bg = gruvbox.palette.dark0_hard,
			fg = gruvbox.palette.light1,
			reverse = false,
		},
	},
	dim_inactive = false,
	transparent_mode = true,
})

vim.cmd("colorscheme gruvbox")
