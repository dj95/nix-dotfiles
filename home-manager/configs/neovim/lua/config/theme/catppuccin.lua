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
local catppuccin = require('catppuccin')
local ucolors = require('catppuccin.utils.colors')

-- vim.g.catppuccin_flavour = "mocha"
vim.o.termguicolors = true

catppuccin.setup({
  flavour = "mocha",
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true,
  term_colors = true,
  compile = {
    enabled = true,
  },
  compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
  highlight_overrides = {
    mocha = function(mocha)
      return {
        FloatBorder = { fg = mocha.mantle, bg = mocha.mantle },
        -- folds
        Folded = { fg = mocha.surface2, bg = mocha.mantle, style = { "italic" } },
        -- lspsage
        LspFloatWinNormal = { bg = mocha.base },
        -- bufferline
        BufferLineTab = { fg = mocha.subtext0, bg = mocha.crust },
        BufferLineTabSelected = { fg = mocha.text, bg = mocha.base },
        BufferLineIndicatorSelected = { fg = mocha.sky, bg = mocha.base },
        -- telescope
        TelescopeNormal = { bg = mocha.mantle },
        TelescopeResultsBorder = { bg = mocha.mantle },
        TelescopeResultsTitle = { bg = mocha.mantle, fg = mocha.mantle },
        TelescopePreviewBorder = { bg = mocha.mantle },
        TelescopePrompt = { bg = mocha.surface0 },
        TelescopePromptNormal = { bg = mocha.surface0 },
        TelescopePromptPrefix = { bg = mocha.surface0 },
        TelescopePromptBorder = { bg = mocha.surface0 },
        TelescopePromptTitle = {
          bg = mocha.surface0,
          fg = mocha.subtext0,
          italic = true,
        },
        TelescopePreviewTitle = { bg = mocha.mantle, fg = mocha.mantle },
        -- diff
        DiffDelete = { bg = ucolors.darken(mocha.red, 0.08, mocha.base), fg = mocha.surface1},
        -- trailing whitespaces
        Whitespace = { bg = "None", fg = mocha.red },
        -- headlines
		Headline1 = { bg = ucolors.blend(mocha.surface0, mocha.red, 0.9), fg = mocha.red },
		Headline2 = { bg = ucolors.blend(mocha.surface0, mocha.peach, 0.9), fg = mocha.peach },
		Headline3 = { bg = ucolors.blend(mocha.surface0, mocha.yellow, 0.9), fg = mocha.yellow },
		Headline4 = { bg = ucolors.blend(mocha.surface0, mocha.green, 0.9), fg = mocha.green },
		Headline5 = { bg = ucolors.blend(mocha.surface0, mocha.sapphire, 0.9), fg = mocha.sapphire },
		Headline6 = { bg = ucolors.blend(mocha.surface0, mocha.lavender, 0.9), fg = mocha.lavender },
      }
    end,
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = { "italic" },
    functions = { },
    keywords = { "italic" },
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = {"italic"},
        hints = {"italic"},
        warnings = {"italic"},
        information = {"italic"},
      },
      underlines = {
        errors = {"undercurl"},
        hints = {"undercurl"},
        warnings = {"undercurl"},
        information = {"undercurl"},
      },
    },
    cmp = true,
    lsp_saga = true,
    gitsigns = true,
    telescope = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    neogit = true,
    notify = true,
    leap = true,
  }
})

-- set up the vim colorscheme
vim.cmd.colorscheme 'catppuccin'
