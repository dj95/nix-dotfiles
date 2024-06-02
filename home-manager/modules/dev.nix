{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    karate
    just
  ];

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
}
