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

-- imports
local bufferline = require "bufferline"
local colors = require'catppuccin.palettes'.get_palette() -- fetch colors with API

-- configure the bufferline at the top of nvim
bufferline.setup{
  options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    buffer_close_icon = " ",
    modified_icon = "",
    close_icon = "",
    show_close_icon = true,
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    view = "multiwindow",
    show_buffer_close_icons = true,
    separator_style = "thin",
    always_show_bufferline = true,
    diagnostics = "nvim_lsp", -- "or nvim_lsp"
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    custom_filter = function(buf_number)
      -- Func to filter out our managed/persistent split terms
      local present_type, type = pcall(function()
        return vim.api.nvim_buf_get_var(buf_number, "term_type")
      end)

      if present_type then
        if type == "vert" then
          return false
        elseif type == "hori" then
          return false
        else
          return true
        end
      else
        return true
      end
    end,
  },
  highlights = {
    background = {
      bg = colors.crust,
    },
    tab = {
      bg = colors.crust,
    },
    tab_selected = {
      fg = colors.overlay2,
    },
    separator = {
      bg = colors.crust,
    },
    close_button = {
      bg = colors.crust,
    },
    tab_close = {
      bg = colors.crust,
    },
    buffer = {
      bg = colors.crust,
    },
    buffer_selected = {
      fg = colors.overlay2,
    },
    error = {
      fg = colors.red,
      bg = colors.crust,
    },
    error_diagnostic = {
      fg = colors.red,
      bg = colors.crust,
    },
    error_visible = {
      fg = colors.red,
    },
  },
}
