{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages = with pkgs; [
    nodejs
    yarn
    nodePackages.pnpm
    nodePackages.typescript
  ];
}
