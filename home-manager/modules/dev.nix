{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    cmake
    frizbee
    karate
    just
    hugo
    ollama
    stylelint
  ];

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
}
