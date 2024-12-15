{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    bash
    bottom
    cbonsai
    coreutils-prefixed
    curl
    difftastic
    du-dust
    fd
    fontconfig
    fzf
    gcc
    gnugrep
    glow
    htop
    jq
    maple-mono-NF
    sketchybar-app-font
    nmap
    # ollama
    openssl
    pv
    ripgrep
    rsync
    smartcat
    tailspin
    terminaltexteffects
    tree
    typst
    unzip
    watch
    wget
    yq
    zip
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin-mocha";
    };
    themes = {
      Catppuccin-mocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat"; # Bat uses sublime syntax for its themes
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "/Catppuccin-mocha.tmTheme";
      };
      RosePine = {
        src = pkgs.fetchFromGitHub {
          owner = "rose-pine";
          repo = "tm-theme"; # Bat uses sublime syntax for its themes
          rev = "c4235f9a65fd180ac0f5e4396e3a86e21a0884ec";
          sha256 = "sha256-jji8WOKDkzAq8K+uSZAziMULI8Kh7e96cBRimGvIYKY=";
        };
        file = "/dist/themes/rose-pine.tmTheme";
      };
    };
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
  };

  xdg.configFile."tailspin/config.toml".text = ''
    [[regexps]]
    regular_expression = '^[a-z0-9]+\s{2,}[a-zA-Z]+\s{2,}[a-zA-Z]+\s{2,}([a-zA-Z0-9-/]+)\s{2,}'
    style = { fg = "cyan" }

    [[regexps]]
    regular_expression = '^[a-z0-9]+\s{2,}[a-zA-Z]+\s{2,}([a-zA-Z]+)\s{2,}'
    style = { fg = "green", italic = true }

    [[regexps]]
    regular_expression = '^[a-z0-9]+\s{2,}([a-zA-Z]+)\s{2,}'
    style = { fg = "blue", bold = true }

    [[regexps]]
    regular_expression = '^([a-z0-9]+)\s{2,}'
    style = { fg = "yellow" }
  '';
}
