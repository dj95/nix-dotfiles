{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    cargo
    rustc
  ];
}
