-- configure the bufferline at the top of nvim
require("bufferline").setup{
    options = {
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      buffer_close_icon = " ",
      modified_icon = "",
      -- close_icon = "%@NvChad_bufferline_quitvim@%X",
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
      diagnostics = false, -- "or nvim_lsp"
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
      fill = {
         guifg = "#ff8170",
         guibg = "#393b44",
      },
      background = {
         guifg = "#dfdfe0",
         guibg = "#393b44",
      },

      -- buffers
      buffer_selected = {
         guifg = "#dfdfe0",
         guibg = "#292a30",
         gui = "bold",
      },
      buffer_visible = {
         guifg = "#dfdfe0",
         guibg = "#393b44",
      },

      -- close buttons
      close_button = {
         guifg = "#53606e",
         guibg = "#393b44",
      },
      close_button_visible = {
         guifg = "#53606e",
         guibg = "#393b44",
      },
      close_button_selected = {
         guifg = "#ff8170",
         guibg = "#292a30",
      },

      -- indicator
      indicator_selected = {
         guifg = "#ABB0C9",
         guibg = "#292a30",
      },

      -- modified
      modified = {
         guifg = "#84b360",
         guibg = "#393b44",
      },
      modified_visible = {
         guifg = "#84b360",
         guibg = "#393b44",
      },
      modified_selected = {
         guifg = "#b0e687",
         guibg = "#292a30",
      },

      -- separators
      separator = {
         guifg = "#393b44",
         guibg = "#393b44",
      },
      separator_visible = {
         guifg = "#393b44",
         guibg = "#393b44",
      },
      separator_selected = {
         guifg = "#292a30",
         guibg = "#292a30",
      },

      -- tabs
      tab = {
         guifg = "#ff8170",
         guibg = "#393b44",
      },
      tab_selected = {
         guifg = "#dfdfe0",
         guibg = "#292a30",
      },
      tab_close = {
         guifg = "#ff8170",
         guibg = "#393b44",
      },
   },
}
