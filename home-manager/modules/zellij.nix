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
    theme "gruvbox-dark"
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
      rose-pine {
		bg "#403d52"
		fg "#e0def4"
		red "#eb6f92"
		green "#31748f"
		blue "#9ccfd8"
		yellow "#f6c177"
		magenta "#c4a7e7"
		orange "#fe640b"
		cyan "#ebbcba"
		black "#26233a"
		white "#e0def4"
      }
    }

    styled_underlines true
    session_serialization false
    serialization_interval 1

    env {
      TERM "xterm-ghostty"
    }

    pane_frames false
    ui {
      pane_frames {
        rounded_corners true
      }
    }

    default_shell "fish"

    keybinds {
      tmux {
        bind "Ctrl a" { Write 1; SwitchToMode "Normal"; }
        bind "[" { SwitchToMode "Scroll"; }
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
          LaunchOrFocusPlugin "zj-smart-sessions" {
            floating true
            move_to_focused_tab true
          };
          SwitchToMode "Normal"
        }
        bind "S" {
          LaunchOrFocusPlugin "zj-smart-sessions" {
            floating true
            move_to_focused_tab true
            find_command "${pkgs.bash}/bin/bash /Users/${config.home.username}/.config/zellij/find_command"
            base_path "/Users/${config.home.username}/Developer"
          };
          SwitchToMode "Normal"
        }
      }
      shared_except "tmux" "locked" {
        bind "Ctrl a" { SwitchToMode "Tmux"; }
      }
      shared_except "locked" {
        bind "Ctrl q" {
          LaunchOrFocusPlugin "zj-quit" {
            floating true
          }
        }
      }
    }

    plugins {
      zjstatus location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
        hide_frame_for_single_pane "false"

        // catppuccin
        color_bg     "#0e0801"
        color_fg     "#9399B2"
        color_fg_dim "#6C7086"
        color_blue   "#89b4fa"
        color_orange "#ffc387"

        // gruvbox-dark
        color_bg     "#1d2021"
        color_fg     "#ebdbb2"
        color_fg_dim "#928374"
        color_orange "#fe8019"

        // rose-pine
        // color_bg     "#33362E"
        // color_fg     "#9ccfd8"
        // color_fg_dim "#56949f"
        // color_blue   "#31748f"
        // color_orange "#f6c177"

        format_left  "#[fg=$fg,bg=$bg,bold] {session}#[bg=$bg] {tabs}"
        format_right "{notifications}{command_aws}{command_kubectx}{command_kubens}{datetime}"
        format_space "#[bg=$bg]"

        notification_format_unread           "#[fg=$blue,bg=$bg,blink]  #[fg=$blue,bg=$bg] {message} "
        notification_format_no_notifications ""
        notification_show_interval           "10"

        mode_normal          "#[bg=$blue] "
        mode_tmux            "#[bg=$orange] "
        mode_default_to_mode "tmux"

        tab_normal               "#[fg=$fg_dim,bg=$bg] {index} {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
        tab_active               "#[fg=$fg,bg=$bg,bold] {index} {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
        tab_sync_indicator       " "
        tab_fullscreen_indicator "󰊓 "
        tab_floating_indicator   "󰹙 "

        command_kubectx_command  "${pkgs.kubectx}/bin/kubectx -c"
        command_kubectx_format   "#[fg=$fg_dim,bg=$bg,italic]{stdout}#[fg=#424554,bg=$bg]::"
        command_kubectx_interval "2"

        command_kubens_command  "${pkgs.kubectx}/bin/kubens -c"
        command_kubens_format   "#[fg=$fg_dim,bg=$bg]{stdout} "
        command_kubens_interval "2"

        command_aws_command    "${pkgs.fish}/bin/fish -c 'if test $AWS_PROFILE; echo -n \"#[fg=#928374,bg=#1d2021,italic]aws#[fg=#424554,bg=#1d2021]::#[fg=#928374,bg=#1d2021]$AWS_PROFILE  \"; end'"
        command_aws_format     "{stdout}"
        command_aws_interval   "2"
        command_aws_rendermode "dynamic"

        datetime          "#[fg=$fg,bg=$bg] {format} "
        datetime_format   "%A, %d %b %Y %H:%M"
        datetime_timezone "Europe/Berlin"
      }

      zj-quit location="file:${pkgs.zj-quit}/bin/zj-quit.wasm" {
        confirm_key "y"
        cancel_key  "n"
      }

      zj-smart-sessions location="file:${pkgs.zj-smart-sessions}/bin/zj-smart-sessions.wasm"
    }
  '';

  xdg.configFile."zellij/layouts".source = ../configs/zellij/layouts;
  xdg.configFile."zellij/find_command".text = ''
#!/usr/bin/env bash
pushd ~/Developer > /dev/null
fd -t d -u -I \
    -E node_modules \
    -E vendor \
    --no-ignore-vcs '^.git$' | xargs -I{} echo "{}" | sed -re 's|.git/||g'
  '';
}
