{
  config,
  pkgs,
  libs,
  ...
}:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
}
