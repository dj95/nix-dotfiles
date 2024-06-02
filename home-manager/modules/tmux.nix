{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [ tmuxinator ];

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    historyLimit = 10000;
    escapeTime = 1;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    prefix = "C-a";
    customPaneNavigationAndResize = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.battery;
        extraConfig = ''
          color_active="#ffc387"
          color_text="#9399B2"
          color_comments="#6C7086"
          color_selection="#313244"
          color_bg="#181825"
          color_bg_alt="#11111B"
          color_bg_alt2="#45475A"
          color_text_dim="#7C8099"
          color_blue="#89B4FA"
          color_overlay0="#6C7086"
          color_overlay2="#9399B2"

          set -g status-bg "$color_bg"

          set -g status-justify "left"
          set -g status "on"
          set -g status-left-length "100"
          set -g status-style "bg=default"
          set -g message-command-style "fg=colour8"
          set -g pane-border-style "fg=colour236"
          set -g pane-active-border-style "fg=$color_text"
          set -g status-right-length "100"

          set -g @batt_icon_status_charged ' '
          set -g @batt_icon_status_charging ' '
          set -g @batt_icon_status_discharging ' '
          set -g @batt_color_charge_primary_tier8 $color_comments
          set -g @batt_color_charge_primary_tier7 $color_comments
          set -g @batt_color_charge_primary_tier6 $color_comments
          set -g @batt_color_charge_primary_tier5 $color_comments
          set -g @batt_color_charge_primary_tier4 $color_comments
          set -g @batt_color_charge_primary_tier3 $color_comments
          set -g @batt_color_charge_primary_tier2 $color_comments
          set -g @batt_color_charge_primary_tier1 $color_comments
          set -g @batt_icon_charge_tier8 ''
          set -g @batt_icon_charge_tier7 ''
          set -g @batt_icon_charge_tier6 ''
          set -g @batt_icon_charge_tier5 ''
          set -g @batt_icon_charge_tier4 ''
          set -g @batt_icon_charge_tier3 ''
          set -g @batt_icon_charge_tier2 ''
          set -g @batt_icon_charge_tier1 ''

          set -g status-left "#[bg=$color_blue] #[fg=$color_blue,bg=default,bold] #S #[fg=$color_selection,bg=default,nobold,nounderscore,noitalics]#[fg=default] "
          set -g status-right "#[bg=default,fg=$color_overlay0]#{battery_icon_status}#{battery_percentage}  #[bg=default,fg=$color_overlay2]%A, %d %b %Y %H:%M "

          setw -g window-status-format "#[fg=$color_overlay0,bg=default,nobold,noitalics,nounderscore] #I #W "
          setw -g window-status-current-format "#[fg=$color_overlay2,bg=default,bold,nounderscore,italics] #I #W "
        '';
      }
    ];
    extraConfig = ''
      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g set-titles on
      set-option -g detach-on-destroy off

      set -ag terminal-overrides ",xterm-256color:RGB"

      set-option -g focus-events on

      set -g set-titles on
      set -g set-titles-string "#T"

      # Mouse works as expected
      set -g mouse on
      set-option -s set-clipboard off

      # easy-to-remember split pane commands
      bind | split-window -h
      bind - split-window -v
      bind S run-shell "tmux neww fish -c dev"
      unbind '"'
      unbind %

      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
    '';
  };
}
