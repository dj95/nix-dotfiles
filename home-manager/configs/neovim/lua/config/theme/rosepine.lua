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
-- Date: 06.10.2024
--

local vim = vim
local rosepine = require('rose-pine')

rosepine.setup({
    styles = {
        transparency = true
    },
    palette = {
        main = {
            base = "#33362E",
            surface = "#2E302A",
            overlay = "#33362E",
        }
    },
    highlight_groups = {
        -- telescope
        TelescopeNormal = { bg = "base" },
        TelescopeResultsBorder = { bg = "base" },
        TelescopeResultsTitle = { bg = "base", fg = "base" },
        TelescopePreviewBorder = { bg = "base" },
        TelescopePrompt = { bg = "surface" },
        TelescopePromptNormal = { bg = "surface" },
        TelescopePromptPrefix = { bg = "surface" },
        TelescopePromptBorder = { bg = "surface" },
        TelescopePromptTitle = {
          bg = "surface",
          fg = "subtle",
          italic = true,
        },
        TelescopePreviewTitle = { bg = "base", fg = "base" },

        -- leap
        LeapBackdrop = { link = "Comment" },
        LeapMatch = { fg = "foam", bg = "None", bold = true, nocombine = true },
        LeapLabel = { fg = "rose", bg = "None", bold = true, nocombine = true },

        -- lspsaga
        LspFloatWinNormal = { bg = "surface" },

        -- diff
        DiffDelete = { bg = "love", fg = "muted", blend = 10},

        -- folds
        Folded = { fg = "muted", bg = "base", italic = true  },

        -- statusline
		StatusLine = { fg = "foam", bg = "foam", blend = 10 },
		StatusLineNC = { fg = "subtle", bg = "surface" },

        -- search
        CurSearch = { fg = "base", bg = "leaf", inherit = false },
		Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },

        -- trailing whitespaces
        Whitespace = { bg = "None", fg = "love" },

        -- markview
        MarkviewCode = { bg = "surface" },
        MarkviewInlineCode = { bg = "surface" },
        MarkviewBlockQuoteDefault = { bg = "surface" },
        MarkviewBlockQuoteError = { fg = "love", bg = "love", blend = 10 },
        MarkviewBlockQuoteWarn = { fg = "gold", bg = "gold", blend = 10 },
        MarkviewBlockQuoteNote = { fg = "foam", bg = "foam", blend = 10 },
        MarkviewHeading1 = { fg = "love", bg = "love", blend = 10 },
        MarkviewHeading2 = { fg = "gold", bg = "gold", blend = 10 },
        MarkviewHeading3 = { fg = "rose", bg = "rose", blend = 10 },
        MarkviewHeading4 = { fg = "pine", bg = "pine", blend = 10 },
        MarkviewHeading5 = { fg = "foam", bg = "foam", blend = 10 },
        MarkviewHeading6 = { fg = "iris", bg = "iris", blend = 10 },
	},
})

vim.cmd("colorscheme rose-pine")
