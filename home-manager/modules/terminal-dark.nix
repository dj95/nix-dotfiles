{ config, pkgs, libs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "SF Mono";
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

background  #292a30
foreground  #dfdfe0

cursor                #53606e

selection_foreground  #53606e
selection_background  #393b44

color0  #292a30
color8  #53606e

# red
color1                #ff8170
# pink
color9                #ff7ab2

# teal
color2                #78c2b3
# lighy teal
color10               #acf2e4

# yellow
color3                #ffa14f
# light yellow
color11               #d9c97c

# blue
color4                #4eb0cc
# light blue
color12               #6bdfff

# purple
color5                #b281eb
# light purple
color13               #dabaff

# green
color6                #84b360
# light green
color14               #b0e687

# light gray
color7                #a3b1bf
# dark gray
color15               #53606e

shell ${config.home.homeDirectory}/.nix-profile/bin/fish

macos_titlebar_color background
    '';
  };
}
