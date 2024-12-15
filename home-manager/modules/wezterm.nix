{
  config,
  pkgs,
  libs,
  ...
}:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').moon

      local colors = theme.colors()
      colors.background = "#3F4239"
      colors.cursor_fg = "#ffffff"
      colors.cursor_bg = "#ffffff"

      local center_content = function(window, pane)
          local win_dim = window:get_dimensions()
          local tab_dim = pane:tab():get_size()
          local overrides = window:get_config_overrides() or {}
          local padding_left = (win_dim.pixel_width - tab_dim.pixel_width) / 2
          local padding_top = (win_dim.pixel_height - tab_dim.pixel_height) / 2
          local padding_bottom = 0

          if padding_top > 8 then
            padding_top = "0.5cell"
            padding_bottom = "0.5cell"
          end

          local new_padding = {
              left = "1cell",
              right = "1cell",
              top = padding_top,
              bottom = padding_bottom,
          }
          if overrides.window_padding and new_padding.left == overrides.window_padding.left then
              return
          end
          overrides.window_padding = new_padding
          window:set_config_overrides(overrides)
      end

      wezterm.on('window-resized', center_content)
      wezterm.on('window-config-reloaded', center_content)

      return {
        -- font
        font = wezterm.font_with_fallback {
          {
            family = "Maple Mono",
            harfbuzz_features = { "+ss01", "+ss02", "+ss04", "+ss05" },
          },
          "Apple Color Emoji",
        },
        font_size = 15.0,
        line_height = 1.6;
        freetype_load_target = "Light";
        freetype_render_target = "Light";

        -- render settings
        front_end = "WebGpu",
        webgpu_power_preference = "HighPerformance",
        enable_wayland = false,

        -- colorscheme + cursor
        color_scheme = "Catppuccin Mocha",
        default_cursor_style = "SteadyBar",

        -- shell and terminfo
        default_prog = { '${pkgs.fish}/bin/fish', '-l' },
        term = "xterm-256color",

        -- disable tabs and title bar
        use_fancy_tab_bar = true,
        enable_tab_bar = false,
        window_decorations = "RESIZE",

        -- performance
        max_fps = 120,

        -- window
        window_background_opacity = 0.80,
        macos_window_background_blur = 200,
        window_padding = {
          left = '1cell',
          right = '1cell',
          top = '1cell',
          bottom = '0.5cell',
        },
      }
    '';
  };
}
