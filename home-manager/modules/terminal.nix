{ config, pkgs, libs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Hack Nerd Font";
      size = if pkgs.stdenv.isDarwin then 11 else 9;
    };
    extraConfig = ''
symbol_map U+2504-U+2580 Source Code Pro
box_drawing_scale 0.001, 0.2, 1.5, 2
cursor #848484
cursor_shape beam
cursor_blink_interval 0
enable_audio_bell no
window_border_width 0.0
draw_minimal_borders no
placement_strategy center

foreground #373b41
background #faf9f6

color0 #1d1f21
color8 #969896

color1 #cc342b
color9 #cc342b

color2  #198844
color10 #198844

color3  #fba922
color11 #fba922

color4  #3971ed
color12 #3971ed

color5  #a36ac7
color13 #a36ac7

color6  #3971ed
color14 #3971ed

color7  #c5c8c6
color15 #ffffff

shell ${config.home.homeDirectory}/.nix-profile/bin/fish

macos_titlebar_color background
    '';
  };
}
