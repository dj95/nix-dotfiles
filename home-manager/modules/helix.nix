{
  config,
  pkgs,
  libs,
  ...
}:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
    };
  };
}
