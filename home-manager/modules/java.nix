{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    jdk21
    gradle
    jython
  ];
}
