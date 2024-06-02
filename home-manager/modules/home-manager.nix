{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.stateVersion = "23.05";

  home.packages = with pkgs; [ home-manager ];

  programs.home-manager.enable = true;
  programs.man.enable = false;
  home.extraOutputsToInstall = [ "man" ];

  home.sessionVariables = { };
}
