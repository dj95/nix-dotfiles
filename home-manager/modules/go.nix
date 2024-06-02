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
  ];
}
