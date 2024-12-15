# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  hyprland,
  inputs,
  ...
}:

let
  rpathLibs = [
    pkgs.xorg.libXinerama
    pkgs.xorg.libX11
  ];
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 1;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.overlays = [
    (import ../../overlays/argo-helm-updater.nix)
    (import ../../overlays/frizbee.nix)
    (import ../../overlays/gherkin-lint.nix)
    (import ../../overlays/kubectx.nix)
    (import ../../overlays/kustomize-quick-create.nix)
    (import ../../overlays/mutagen-compose.nix)
    (import ../../overlays/terminaltexteffects.nix)
    (final: prev: { zjstatus = inputs.zjstatus.packages.${prev.system}.default; })
    (final: prev: { zj-quit = inputs.zj-quit.packages.${prev.system}.default; })
    (final: prev: { argo-helm-updater = inputs.argo-helm-updater.packages.${prev.system}.default; })
  ];

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      trusted-users = root daniel
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
  };
  environment.variables.NIXOS_OZONE_WL = "1";
  environment.variables.VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
  environment.sessionVariables.LIBVA_DRIVER_NAME = "nvidia";
  environment.sessionVariables.GBM_BACKEND = "nvidia-drm";
  environment.sessionVariables.__GLX_VENDOR_LIBRARY_NAME = "nvidia";
  environment.sessionVariables.XDG_SESSION_TYPE = "wayland";
  environment.sessionVariables.NVD_BACKEND = "direct";

  services.libinput = {
    enable = true;

    mouse = {
      accelProfile = "flat";
    };
  };

  services.xserver = {
    enable = true;


    # xrandrHeads = [
    #   {
    #     output = "DP-4.8";
    #     primary = true;
    #     monitorConfig = ''
    #       Option "Enable" "true"
    #       Option "PreferredMode" "2560x1440"
    #       Option "DPMS" "false"
    #     '';
    #   }
    #   {
    #     output = "DP-4.1.8";
    #     monitorConfig = ''
    #       Option "Enable" "true"
    #       Option "PreferredMode" "2560x1440"
    #       Option "DPMS" "false"
    #     '';
    #   }
    # ];
    #
    # screenSection = ''
    #   Option         "metamodes" "DP-4.8: nvidia-auto-select +0+560 {ForceFullCompositionPipeline=On}, DP-4.1.8: nvidia-auto-select +2560+0 {ForceFullCompositionPipeline=On, Rotation=left}"
    #   Option         "AllowIndirectGLXProtocol" "off"
    #   Option         "TripleBuffer" "on"
    # '';

    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      options = "ctrl:nocaps,compose:rwin";
    };
  };

  services.displayManager = {
    # startx = {
    #   enable = true;
    # };
    sddm = {
      enable = true;
      wayland = {
        enable = true;
      };
    };
  };

  services.udev = {
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"
    '';
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "libvirtd"
    ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    chromium
    home-manager
    mesa
    git
    emacs
    mesa
    openvswitch
    swaylock
    nvidia-vaapi-driver
    egl-wayland
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.pipewire.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
