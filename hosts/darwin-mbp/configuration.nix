{
  config,
  lib,
  pkgs,
  ...
}:

{
  nix.settings.trusted-users = [ "daniel" ];

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions =
    ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      build-users-group = nixbld
    ''
    + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "copilot.vim"
      "intelephense"
      "terraform"
    ];
  nix.settings.max-jobs = 6;

  programs.fish.enable = true;
  programs.fish.shellInit = ''
    for p in (string split : ${config.environment.systemPath})
      if not contains $p $fish_user_paths
        set -g fish_user_paths $fish_user_paths $p
      end
    end
  '';
  environment.variables.SHELL = "${pkgs.fish}/bin/fish";
  nixpkgs.config.allowBroken = true;

  programs.nix-index.enable = true;
  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
