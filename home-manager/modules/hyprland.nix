{
  config,
  lib,
  pkgs,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=,preferred,auto,1
      monitor=DP-2,preferred,0x0,1.5
      monitor=DP-1,preferred,2560x0,1.0

      exec-once = hyprpaper --config /home/daniel/.config/hypr/hyprpaper.conf
      exec-once = waybar
      exec-once = mako

      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = WLR_NO_HARDWARE_CURSORS,1

      input {
        kb_layout = us
        kb_options=ctrl:nocaps

        touchpad {
          natural_scroll = yes
        }

        accel_profile = flat
      }

      general {
        gaps_in = 4
        gaps_out = 8
        border_size = 1
        col.active_border = 0xff6c7086
        col.inactive_border = 0xff11111b
        layout = dwindle
      }

      animations {
        enabled = 1
        bezier = overshot, 0.05, 0.9, 0.1, 1.05
        bezier = smoothOut, 0.36, 0, 0.66, -0.56
        bezier = smoothIn, 0.25, 1, 0.5, 1
        animation = windows, 1, 5, overshot, slide
        animation = windowsOut, 1, 4, smoothOut, slide
        animation = windowsMove, 1, 4, default
        animation = border, 1, 10, default
        animation = fade, 1, 10, smoothIn
        animation = fadeDim, 1, 10, smoothIn
        animation = workspaces, 1, 6, default
      }

      decoration {
        blur {
          enabled=true
          size=10
          passes=4
          new_optimizations=true
        }
        rounding=5
      }

      bind=SUPER,return,exec,kitty

      bind=SUPER_SHIFT,c,killactive,
      bind=SUPER,d,exec,wofi --show drun -I -m -i
      bind=SUPER_SHIFT,e,exec,wofi-emoji
      bind=SUPER_SHIFT,q,exit,

      # volume
      bind=,122,exec,pamixer -d 5
      bind=,123,exec,pamixer -i 5
      bind=,121,exec,pamixer -t

      # brightness
      bind=,232,exec,brightnessctl set 5%-
      bind=,233,exec,brightnessctl set 5%+

      bind = SUPER_SHIFT,F,fullscreen,
      bind = SUPER_SHIFT,space,togglefloating,

      bind=CTRL_ALT,l,exec,swaylock -c 1e1e2e --inside-color 1e1e2e --ring-color 89b4fa --ring-wrong-color f38ba8 --ring-ver-color 89dceb --key-hl-color a6e3a1 --inside-ver-color 89dceb10 --text-ver-color 89dceb --text-wrong-color f38ba8 --inside-wrong-color f38ba810 --separator-color 1e1e2e --bs-hl-color f38ba8 --ring-clear-color f5e0dc --inside-clear-color f5e0dc10 --text-clear-color f5e0dc
      bind=SUPER_SHIFT,s,exec,grim -g "$(slurp)"

      bind=SUPER,h,movefocus,l
      bind=SUPER,j,movefocus,d
      bind=SUPER,k,movefocus,u
      bind=SUPER,l,movefocus,r

      bind=SUPER_SHIFT,h,movewindow,l
      bind=SUPER_SHIFT,j,movewindow,d
      bind=SUPER_SHIFT,k,movewindow,u
      bind=SUPER_SHIFT,l,movewindow,r

      bind=SUPER,1,workspace,1
      bind=SUPER,2,workspace,2
      bind=SUPER,3,workspace,3
      bind=SUPER,4,workspace,4
      bind=SUPER,5,workspace,5
      bind=SUPER,6,workspace,6
      bind=SUPER,7,workspace,7
      bind=SUPER,8,workspace,8
      bind=SUPER,9,workspace,9
      bind=SUPER,0,workspace,10

      bind=SUPER_SHIFT,1,movetoworkspace,1
      bind=SUPER_SHIFT,2,movetoworkspace,2
      bind=SUPER_SHIFT,3,movetoworkspace,3
      bind=SUPER_SHIFT,4,movetoworkspace,4
      bind=SUPER_SHIFT,5,movetoworkspace,5
      bind=SUPER_SHIFT,6,movetoworkspace,6
      bind=SUPER_SHIFT,7,movetoworkspace,7
      bind=SUPER_SHIFT,8,movetoworkspace,8
      bind=SUPER_SHIFT,9,movetoworkspace,9
      bind=SUPER_SHIFT,0,movetoworkspace,10


      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = SUPER,mouse:272,movewindow
      bindm = SUPER,mouse:273,resizewindow
    '';
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "clock"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          sort-by-number = true;
        };

        pulseaudio = {
          format = "V ⋮ {volume}%";
          format-muted = "V ⋮ mute";
        };

        network = {
          format-wifi = "W ⋮ {ifname} {ipaddr}/{cidr} ({signalStrength}%)";
          format-ethernet = "E ⋮ {ifname} {ipaddr}/{cidr}";
          format-disconnected = "";
          interval = 7;
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "B ⋮ {capacity}%";
          format-charging = "B ⋮ {capacity}% ^";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        clock = {
          format = "{:%d/%m/%Y ⋮ %H:%M}";
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
    style = ''
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;

      * {
        border: none;
        border-radius: 0;
        color: @text;
      }

      window#waybar {
        background-color: shade(@base, 0.9);
        border: 2px solid alpha(@crust, 0.3);
      }

      #workspaces {
        border-radius: 1rem;
        margin: 0px 8px;
      }

      #workspaces button {
        color: #3d3d2d;
        margin: 3px;
        padding: 0px 4px;
      }

      #workspaces button.active {
        color: @flamingo;
        background-color: @surface0;
        border-radius: .2rem;
      }

      #workspaces button:hover {
        color: @rosewater;
      }

      #tray,
      #network,
      #backlight,
      #clock,
      #battery,
      #pulseaudio,
      #custom-lock,
      #custom-power {
        margin: 3px 4px;
        padding: 0px 8px;
        border-radius: .2rem;
      }

      #clock {
        color: @lavender;
        background-color: rgba(180, 190, 254, 0.1);
        margin-right: 8px;
      }

      #battery {
        color: @green;
        background-color: rgba(166, 227, 161, 0.1);
      }

      #battery.charging {
        color: @green;
        background-color: rgba(166, 227, 161, 0.1);
      }

      #battery.warning:not(.charging) {
        color: @red;
        background-color: rgba(243, 139, 168, 0.1);
      }

      #network {
          color: @flamingo;
          background: rgba(242, 205, 205, 0.1);
      }

      #backlight {
        color: @yellow;
      }

      #pulseaudio {
        color: @pink;
        background-color: rgba(245, 194, 231, 0.1);
      }

      #pulseaudio.muted {
          color: @red;
          background-color: rgba(243, 139, 168, 0.1);
      }

      #tray {
        border-radius: 1rem;
      }

      tooltip {
          background: @base;
          border: 1px solid @pink;
      }

      tooltip label {
          color: @text;
      }
    '';
  };

  services.mako = {
    enable = true;
    anchor = "bottom-right";
    backgroundColor = "#181825";
    textColor = "#b4befe";
    borderRadius = 9;
    borderColor = "#89b4fa";
  };

  xdg.configFile."hypr/hyprpaper.conf".source = ../configs/hyprland/hyprpaper.conf;
  xdg.configFile."hypr/wallpaper.png".source = ../configs/hyprland/wallpaper.png;

  xdg.configFile."wofi/".source = ../configs/hyprland/wofi;

  home.packages = with pkgs; [
    grim
    hyprpaper
    slurp
    wofi
    wofi-emoji
    wl-clipboard
  ];
}
