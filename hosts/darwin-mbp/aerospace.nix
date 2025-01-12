{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  homebrew = {
    enable = true;
    casks = [
      "ghostty@tip"
    ];
  };
}
