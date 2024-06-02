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
    eza
    fd
    fontconfig
    fzf
    gcc
    gnugrep
    htop
    jq
    maple-mono-NF
    nmap
    ollama
    openssl
    pv
    ripgrep
    rsync
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
    };
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
