{ config, pkgs, libs, ... }:
{
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
    terminal = "screen-256color";
    tmuxinator = {
      enable = true;
    };
    extraConfig = ''
# Automatically set window title
set-window-option -g automatic-rename on
set-option -g set-titles on

set -g set-titles on
set -g set-titles-string "#T"

#Mouse works as expected
set -g mouse on
set-option -s set-clipboard off

# easy-to-remember split pane commands
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# theme
if-shell "test -f ~/.tmux-theme.conf" "source ~/.tmux-theme.conf"
    '';
  };

  # copy the tmux theme
  home.file.".tmux-theme.conf".source = ../configs/tmux/tmux-theme.dark.conf;

  # copy tmuxinator configs
  xdg.configFile."tmuxinator/dev.yml".source = ../configs/tmux/tmuxinator/dev.yml;
}
