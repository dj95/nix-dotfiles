{
  config,
  pkgs,
  libs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Liga SFMono Nerd Font";
      size = if pkgs.stdenv.isDarwin then 18 else 12;
    };
    settings = {
      shell = "${pkgs.fish}/bin/fish";

      macos_titlebar_color = "background";
      macos_option_as_alt = "yes";
      macos_thicken_font = 0;
      macos_show_window_title_in = "window";

      # performance tuning
      repaint_delay = 8;
      input_delay = 0;
      sync_to_monitor = "yes";

      window_border_width = "0.0";
      window_padding_width = 1;
      draw_minimal_borders = "no";
      placement_strategy = "center";

      background_opacity = if pkgs.stdenv.isDarwin then "1.0" else "0.7";

      cursor_shape = "beam";
      cursor_blink_interval = 0;

      adjust_line_height = 18;
      adjust_column_width = 0;

      # The basic colors
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";

      # Cursor colors
      cursor = "#F5E0DC";
      cursor_text_color = "#1E1E2E";

      # URL underline color when hovering with mouse
      url_color = "#F5E0DC";

      # Kitty window border colors
      active_border_color = "#B4BEFE";
      inactive_border_color = "#6C7086";
      bell_border_color = "#F9E2AF";

      # Tab bar colors
      active_tab_foreground = "#11111B";
      active_tab_background = "#CBA6F7";
      inactive_tab_foreground = "#CDD6F4";
      inactive_tab_background = "#181825";
      tab_bar_background = "#11111B";

      # Colors for marks (marked text in the terminal)
      mark1_foreground = "#1E1E2E";
      mark1_background = "#B4BEFE";
      mark2_foreground = "#1E1E2E";
      mark2_background = "#CBA6F7";
      mark3_foreground = "#1E1E2E";
      mark3_background = "#74C7EC";

      # The 16 terminal colors

      # black
      color0 = "#45475A";
      color8 = "#585B70";

      # red
      color1 = "#F38BA8";
      color9 = "#F38BA8";

      # green
      color2 = "#A6E3A1";
      color10 = "#A6E3A1";

      # yellow
      color3 = "#F9E2AF";
      color11 = "#F9E2AF";

      # blue
      color4 = "#89B4FA";
      color12 = "#89B4FA";

      # magenta
      color5 = "#F5C2E7";
      color13 = "#F5C2E7";

      # cyan
      color6 = "#94E2D5";
      color14 = "#94E2D5";

      # white
      color7 = "#BAC2DE";
      color15 = "#A6ADC8";
    };
  };
}
