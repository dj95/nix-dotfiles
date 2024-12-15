{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
{
  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    nix
    skhd
    terminal-notifier
    material-design-icons
    wezterm
  ];

  documentation.enable = false;

  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    mkForce ''
      # Set up applications.
      echo "setting up ~/Applications/Nix Apps..." >&2
      rm -rf ~/Applications/Nix\ Apps
      mkdir -p ~/Applications/Nix\ Apps
      srcs=()
      while read -r src; do
        srcs+=("$src")
      done < <(find ${env}/Applications -maxdepth 1 -type l)
      if [[ "''${#srcs[@]}" != 0 ]]; then
        /bin/cp -LR "''${srcs[@]}" ~/Applications/Nix\ Apps
      fi
    '';

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
