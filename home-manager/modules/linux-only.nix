{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    nixos-shell
    cgdb
    gdb
    nix-du
    nix-index
    nix-prefetch
    nix-prefetch-git
  ];
}
