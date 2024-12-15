{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.jedi
    python3Packages.pynvim
    python3Packages.setuptools
  ];
}
