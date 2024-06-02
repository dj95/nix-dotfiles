{
  config,
  pkgs,
  libs,
  ...
}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;
      window = {
        decorations = if pkgs.stdenv.isDarwin then "buttonless" else "none";
        startup_mode = "Maximized";
        opacity = 0.75;
        blur = true;
        dynamic_title = true;
        padding = {
          x = 4;
          y = 8;
        };
      };
      font = {
        normal = {
          family = "Liga SFMono Nerd Font";
          style = "Light";
        };
        italic = {
          family = "Liga SFMono Nerd Font";
          style = "Light Italic";
        };
        bold = {
          family = "Liga SFMono Nerd Font";
          style = "Semibold";
        };
        bold_italic = {
          family = "Liga SFMono Nerd Font";
          style = "Bold Italic";
        };
        size = if pkgs.stdenv.isDarwin then 18 else 11;
        glyph_offset = {
          y = 5;
        };
        offset = {
          y = 10;
        };
      };
      mouse = {
        hide_when_typing = true;
      };
      colors = {
        primary = {
          foreground = "#cdd6f4";
          background = "#1e1e2e";

          dim_foreground = "#cdd6f4"; # text
          bright_foreground = "#cdd6f4"; # tex
        };
        cursor = {
          text = "#1e1e2e"; # base
          cursor = "#f5e0dc"; # rosewater
        };
        vi_mode_cursor = {
          text = "#1e1e2e"; # base
          cursor = "#b4befe"; # lavender
        };

        # Search colors
        search = {
          matches = {
            foreground = "#1e1e2e"; # base
            background = "#a6adc8"; # subtext0
          };
          focused_match = {
            foreground = "#1e1e2e"; # base
            background = "#a6e3a1"; # green
          };
        };

        # Keyboard regex hints
        hints = {
          start = {
            foreground = "#1e1e2e"; # base
            background = "#f9e2af"; # yellow
          };
          end = {
            foreground = "#1e1e2e"; # base
            background = "#a6adc8"; # subtext0
          };
        };

        # Selection colors
        selection = {
          text = "#1e1e2e"; # base
          background = "#f5e0dc"; # rosewater
        };

        normal = {
          black = "#45475a"; # surface1
          red = "#f38ba8"; # red
          green = "#a6e3a1"; # green
          yellow = "#f9e2af"; # yellow
          blue = "#89b4fa"; # blue
          magenta = "#f5c2e7"; # pink
          cyan = "#94e2d5"; # teal
          white = "#bac2de"; # subtext1
        };

        bright = {
          black = "#585B70"; # surface1
          red = "#f38ba8"; # red
          green = "#a6e3a1"; # green
          yellow = "#f9e2af"; # yellow
          blue = "#89b4fa"; # blue
          magenta = "#f5c2e7"; # pink
          cyan = "#94e2d5"; # teal
          white = "#A6ADC8"; # subtext1
        };

        dim = {
          black = "#45475a"; # surface1
          red = "#f38ba8"; # red
          green = "#a6e3a1"; # green
          yellow = "#f9e2af"; # yellow
          blue = "#89b4fa"; # blue
          magenta = "#f5c2e7"; # pink
          cyan = "#94e2d5"; # teal
          white = "#bac2de"; # subtext1
        };

        indexed_colors = [
          {
            index = 16;
            color = "#FAB387";
          }
          {
            index = 17;
            color = "#F5E0DC";
          }
        ];
      };
      cursor = {
        style = {
          shape = "Beam";
        };
      };
      shell = {
        program = "${pkgs.fish}/bin/fish";
      };
      env = {
        TERM = "alacritty-direct";
      };
    };
  };
}
