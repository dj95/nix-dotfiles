{
  config,
  pkgs,
  libs,
  ...
}:
{
  programs.zellij = {
    enable = true;
  };

  # copy zellij config, until it is propery supported by home-manager
  xdg.configFile."zellij/config.kdl".text = ''
    theme "catppuccin"
    themes {
      catppuccin {
        bg "#585b70"
        fg "#cdd6f4"
        red "#f38ba8"
        green "#89b4fa"
        blue "#89b4fa"
        yellow "#f9e2af"
        magenta "#f5c2e7"
        orange "#fab387"
        cyan  "#89dceb"
        black "#181825"
        white "#cdd6f4"
      }
    }

    styled_underlines true
    session_serialization false
    serialization_interval 1

    env {
      TERM "xterm-256color"
    }

    ui {
      pane_frames {
        rounded_corners true
      }
    }

    default_shell "fish"

    keybinds {
      tmux {
        bind "Ctrl a" { Write 1; SwitchToMode "Normal"; }
        bind "-" { NewPane "Down"; SwitchToMode "Normal"; }
        bind "|" { NewPane "Right"; SwitchToMode "Normal"; }
        bind "1" { GoToTab 1; SwitchToMode "Normal"; }
        bind "2" { GoToTab 2; SwitchToMode "Normal"; }
        bind "3" { GoToTab 3; SwitchToMode "Normal"; }
        bind "4" { GoToTab 4; SwitchToMode "Normal"; }
        bind "5" { GoToTab 5; SwitchToMode "Normal"; }
        bind "6" { GoToTab 6; SwitchToMode "Normal"; }
        bind "7" { GoToTab 7; SwitchToMode "Normal"; }
        bind "8" { GoToTab 8; SwitchToMode "Normal"; }
        bind "9" { GoToTab 9; SwitchToMode "Normal"; }
        bind "0" { GoToTab 10; SwitchToMode "Normal"; }
        bind "s" {
          LaunchOrFocusPlugin "zellij:session-manager" {
            floating true
            move_to_focused_tab true
          };
          SwitchToMode "Normal"
        }
        bind "S" {
          Run "fish" "-c" "dev" {
            direction "down"
          };
          Detach;
        }
      }
      shared_except "tmux" "locked" {
        bind "Ctrl a" { SwitchToMode "Tmux"; }
      }
    }

    plugins {
      zjstatus location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
        hide_frame_for_single_pane "true"

        format_left  "{mode}#[fg=#89B4FA,bg=#181825,bold] {session}#[bg=#181825] {tabs}"
        format_right "{notifications}{command_kubectx}#[fg=#424554,bg=#181825]::{command_kubens}{datetime}"
        format_space "#[bg=#181825]"

        notification_format_unread           "#[fg=#89B4FA,bg=#181825,blink]  #[fg=#89B4FA,bg=#181825] {message} "
        notification_format_no_notifications ""
        notification_show_interval           "10"

        mode_normal          "#[bg=#89B4FA] "
        mode_tmux            "#[bg=#ffc387] "
        mode_default_to_mode "tmux"

        tab_normal               "#[fg=#6C7086,bg=#181825] {index} {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
        tab_active               "#[fg=#9399B2,bg=#181825,bold,italic] {index} {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
        tab_fullscreen_indicator "□ "
        tab_sync_indicator       "  "
        tab_floating_indicator   "󰉈 "

        command_kubectx_command  "${pkgs.kubectx}/bin/kubectx -c"
        command_kubectx_format   "#[fg=#6C7086,bg=#181825,italic] {stdout}"
        command_kubectx_interval "2"

        command_kubens_command  "${pkgs.kubectx}/bin/kubens -c"
        command_kubens_format   "#[fg=#6C7086,bg=#181825]{stdout} "
        command_kubens_interval "2"

        datetime          "#[fg=#9399B2,bg=#181825] {format} "
        datetime_format   "%A, %d %b %Y %H:%M"
        datetime_timezone "Europe/Berlin"
      }
    }
  '';

  xdg.configFile."zellij/layouts".source = ../configs/zellij/layouts;
}
