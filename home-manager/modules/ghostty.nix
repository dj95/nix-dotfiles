{
  config,
  pkgs,
  libs,
  ...
}:
{
  xdg.configFile."ghostty/config".text = ''
    # Fonts
    font-family = Maple Mono
    font-feature = +ss01
    font-feature = +ss02
    font-feature = +ss04
    font-feature = +ss05
    font-size = 15
    adjust-cell-height = +50%
    freetype-load-flags = no-hinting
    window-colorspace = display-p3

    # Theme
    theme = GruvboxDarkHard
    background-opacity = 0.85
    background-blur-radius = 40
    # custom-shader = /Users/${config.home.username}/.config/ghostty/shaders/sparks-from-fire.glsl

    # Shell
    command = ${pkgs.fish}/bin/fish

    # Cursor
    cursor-style = bar
    cursor-style-blink = false
    adjust-cursor-height = +20%
    mouse-hide-while-typing = true

    # Padding
    window-padding-balance = true
    window-padding-color = extend

    # macOS
    macos-titlebar-style = tabs
    macos-titlebar-proxy-icon = hidden
    macos-option-as-alt = true
    confirm-close-surface = false

    # Shortcuts
    keybind = alt+left=unbind
    keybind = alt+right=unbind
  '';

  xdg.configFile."ghostty/shaders/sparks-from-fire.glsl".source = ../configs/ghostty/sparks-from-fire.glsl;
  xdg.configFile."ghostty/themes/pasteldark".text = ''
palette = 0=#131a21
palette = 1=#ef8891
palette = 2=#9fe8c3
palette = 3=#fbdf90
palette = 4=#99aee5
palette = 5=#c2a2e3
palette = 6=#92dbb6
palette = 7=#363d44
palette = 8=#1a2128
palette = 9=#ef8891
palette = 10=#9ce5c0
palette = 11=#fbdf90
palette = 12=#9aa8cf
palette = 13=#b696d7
palette = 14=#92dbb6
palette = 15=#363d44
background = 131a21
foreground = b5bcc9
cursor-color = b5bcc9
selection-background = 626880
selection-foreground = c6d0f5
  '';
}
