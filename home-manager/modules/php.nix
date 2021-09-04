{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    php80
    php80Packages.composer
  ];
}
