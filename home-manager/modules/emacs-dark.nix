{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
  ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ../configs/emacs/doom.d.dark;
    emacsPackage = pkgs.emacsGcc;
  };

  home.file.".doom.d/".source = ../configs/emacs/doom.d.dark;
}
