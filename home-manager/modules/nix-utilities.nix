{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    nix-prefetch-github
    nixpkgs-review
    nixpkgs-fmt
    nixfmt-rfc-style
  ];
}
