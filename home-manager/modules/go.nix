{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    go
    golint
    gosec
    gomodifytags
    gotests
    gotestsum
    gore
  ];
}
