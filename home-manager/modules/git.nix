{
  config,
  pkgs,
  libs,
  ...
}:
{
  home.packages =
    with pkgs;
    if pkgs.stdenv.isDarwin then
      [
        git-cliff
        git-lfs
        pinentry_mac
      ]
    else
      [
        git-cliff
        git-lfs
      ];

  programs.gpg = {
    enable = true;
    settings = {
      auto-key-retrieve = true;
    };
  };

  home.file.".gnupg/gpg-agent.conf".text =
    if pkgs.stdenv.isDarwin then
      ''
        default-cache-ttl 600
        max-cache-ttl 7200
        pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      ''
    else
      ''
        default-cache-ttl 600
        max-cache-ttl 7200
        pinentry-program ${pkgs.pinentry-qt}/bin/pinentry
      '';

  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
    signing = {
      signByDefault = true;
    };
  };

  home.file.".config/git/ignore".text = ''
    tags
    result
    *.sw[op]
    .DS_STORE
  '';
}
