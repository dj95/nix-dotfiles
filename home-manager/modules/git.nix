{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    git-lfs
  ];

  programs.git = {
    enable = true;
  };

  home.file.".config/git/ignore".text = ''
    tags
    result
    *.sw[op]
    .DS_STORE
  '';
}
