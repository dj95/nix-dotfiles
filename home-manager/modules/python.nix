{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    python39
    python39Packages.jedi
    python39Packages.pynvim
  ];
}
