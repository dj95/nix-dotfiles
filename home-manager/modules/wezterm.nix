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
      return {
        -- font
        font = wezterm.font_with_fallback {
          {
            family = "Liga SFMono Nerd Font",
            harfbuzz_features = { "+ss01", "+ss02", "+ss04", "+ss05" },
          },
          "Apple Color Emoji",
        },
        font_size = 20.0,
        line_height = 1.4;
        freetype_load_target = "Light";
        freetype_render_target = "Light";

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
        window_background_opacity = 0.95,
        macos_window_background_blur = 200,
        window_padding = {
          top = 0,
          bottom = 0,
          left = 2,
          right = 2,
        },
      }
    '';
  };
}
