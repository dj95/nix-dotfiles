{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    cmake
    ctags
    curl
    fd
    fontconfig
    fzf
    htop
    nerdfonts
    nmap
    ripgrep
    rsync
    shellcheck
    watch
    wget
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
    themes = {
      GitHub = builtins.readFile (pkgs.fetchFromGitHub {
        owner = "sethlopezme";
        repo = "InspiredGithub.tmtheme"; # Bat uses sublime syntax for its themes
        rev = "bfd9f580d24cf65b6b73c104a08aae51512e4a5c";
        sha256 = "3t+tg7Vkdm0hj5QB0bvpig5XcPlvnJ1oh0DKjoARAWs=";
      } + "/InspiredGitHub.tmTheme");
    };
  };
}
