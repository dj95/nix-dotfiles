{ config, pkgs, libs, ... }:
{
  home.stateVersion = "20.09";

  programs.home-manager.enable = true;
  programs.man.enable = false;
  home.extraOutputsToInstall = [ "man" ];

  home.sessionVariables = {
  };
}
