{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    config = {
      # general
      layout = "bsp";
      auto_balance = "off";
      split_ratio = 0.5;
      window_placement = "second_child";
      window_opacity = "off";
      window_animation_duration = "0.0";
      window_border_blur = "off";

      # mouse
      mouse_modifier = "alt";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";

      # spacing
      top_padding = 8;
      bottom_padding = 8;
      left_padding = 8;
      right_padding = 8;
      window_gap = 8;

      # borders
      window_border = "off";
      window_border_width = 2;
      active_window_border_color = "0xffA6ADC8";
      normal_window_border_color = "0xff45475a";
      insert_feedback_color = "0xffd75f5f";
    };
    extraConfig = ''
      # handle non-tilable applications
      yabai -m rule --add app='^System Information$' manage=off
      yabai -m rule --add app='^System Preferences$' sticky=on sub-layer=above manage=off
      yabai -m rule --add app='^System Settings$' sticky=on sub-layer=above manage=off
      yabai -m rule --add app='^Steam$' manage=off
      yabai -m rule --add title='Preferences$' manage=off
      yabai -m rule --add title='Info$' manage=off
      yabai -m rule --add title='Settings$' manage=off
      yabai -m rule --add layer='above$' manage=off

      # set apps to certain spaces
      yabai -m rule --add app='^Chromium$' space=2
      yabai -m rule --add app='^Firefox$' space=2
      yabai -m rule --add app='^Music$' space=8
      yabai -m rule --add app='^Calendar$' space=9
      yabai -m rule --add app='^Mail$' space=9
      yabai -m rule --add app='^Microsoft Teams$' space=10

      ${pkgs.skhd}/bin/skhd --reload
    '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # set layout
      cmd + ctrl - t : yabai -m space --layout bsp
      cmd + ctrl - f : yabai -m space --layout float
      cmd + ctrl - s : yabai -m space --layout stack

      # fullscreen
      cmd + shift - f : yabai -m window --toggle zoom-fullscreen

      # focus windows
      cmd + ctrl - h : yabai -m window --focus west
      cmd + ctrl - j : yabai -m window --focus south
      cmd + ctrl - k : yabai -m window --focus north
      cmd + ctrl - l : yabai -m window --focus east

      # swap windows
      cmd + ctrl + shift - h : yabai -m window --swap west
      cmd + ctrl + shift - j : yabai -m window --swap south
      cmd + ctrl + shift - k : yabai -m window --swap north
      cmd + ctrl + shift - l : yabai -m window --swap east

      # snap windows
      cmd + shift - h : yabai -m window --grid 2:2:0:0:1:2
      cmd + shift - j : yabai -m window --grid 2:2:0:1:2:1
      cmd + shift - k : yabai -m window --grid 2:2:0:0:2:1
      cmd + shift - l : yabai -m window --grid 2:2:1:0:1:2

      # move active window to space
      cmd + shift - 1 : yabai -m window --space 1
      cmd + shift - 2 : yabai -m window --space 2
      cmd + shift - 3 : yabai -m window --space 3
      cmd + shift - 4 : yabai -m window --space 4
      cmd + shift - 5 : yabai -m window --space 5
      cmd + shift - 6 : yabai -m window --space 6
      cmd + shift - 7 : yabai -m window --space 7
      cmd + shift - 8 : yabai -m window --space 8
      cmd + shift - 9 : yabai -m window --space 9
      cmd + shift - 0 : yabai -m window --space 10

      # window controls
      cmd + shift - m : yabai -m window --grid 1:1:0:0:1:1

      # open some apps
      cmd - return : open -n -a 'wezterm.app'

      # displays
      cmd + shift - 0x2B : bash -c 'yabai -m window --display prev && yabai -m display --focus prev'
      cmd + shift - 0x2F : bash -c 'yabai -m window --display next && yabai -m display --focus next'
      cmd + ctrl - 0x2B : bash -c 'yabai -m display --focus prev'
      cmd + ctrl - 0x2F : bash -c 'yabai -m display --focus next'
    '';
  };
}
