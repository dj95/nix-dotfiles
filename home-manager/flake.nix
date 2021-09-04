{
  description = "nix configuration for setting up my development environment.";

  # define external resources to fetch the configuration from
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    doom-emacs = {
      url = "github:hlissner/doom-emacs";
      flake = false;
    };

    nix-doom-emacs = {
      url = "github:vlaci/nix-doom-emacs/656a3aea172d6fb99a1d6e5c45667121855e5996";
      inputs.emacs-overlay.follows = "emacs-overlay";
      inputs.doom-emacs.follows = "doom-emacs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-straight = {
        url = github:0x450x6c/nix-straight.el/a2379105b7506094a818de1486fa8f2525854149;
        flake = false;
      };
    };


    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
    };
  };


  # define the outputs of this flake - especially the home configurations
  outputs = inputs @ { self, nixpkgs, nix-doom-emacs, ... }:
  let
    overlays = [
      inputs.emacs-overlay.overlay
    ];
    in
    # legacyPackages attribute for declarative channels (used by compat/default.nix)
    inputs.flake-utils.lib.eachDefaultSystem (system:
    {
      legacyPackages = inputs.nixpkgs.legacyPackages.${system};
    }
    ) //
  {
    homeConfigurations = {
      #
      # macbook pro
      #
      macbook-pro = inputs.home-manager.lib.homeManagerConfiguration {
        configuration = { pkgs, config, ... }:
          {
            # set the user nix config
            xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
            nixpkgs.config = import ./configs/nix/config.nix;
            nixpkgs.overlays = overlays;

            # import relevant modules for this configuration
            imports = [
              # general
              ./modules/cli-dark.nix
              ./modules/fish-dark.nix
              ./modules/git.nix
              ./modules/home-manager.nix
              ./modules/nix-utilities.nix
              ./modules/terminal-dark.nix
              ./modules/tmux-dark.nix

              # development
               nix-doom-emacs.hmModule
              ./modules/dev.nix
              ./modules/emacs-dark.nix
              ./modules/neovim-dark.nix
              ./modules/ops.nix

              # programming languages
              ./modules/go.nix
              ./modules/node.nix
              ./modules/php.nix
              ./modules/python.nix
            ];
          };
        system = "x86_64-darwin";
        homeDirectory = "/Users/daniel";
        username = "daniel";
      };

      #
      # linux configuration
      #
      linux-desktop = inputs.home-manager.lib.homeManagerConfiguration {configuration = { pkgs, ... }:
          {
            # set the user nix config
            xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
            nixpkgs.config = import ./configs/nix/config.nix;
            nixpkgs.overlays = overlays;

            # import relevant modules for this configuration
            imports = [
              # general
              ./modules/cli.nix
              ./modules/fish.nix
              ./modules/git.nix
              ./modules/home-manager.nix
              ./modules/nix-utilities.nix
              ./modules/linux-only.nix
              ./modules/ssh.nix
              ./modules/terminal.nix
              ./modules/tmux.nix

              # development
               nix-doom-emacs.hmModule
              ./modules/dev.nix
              ./modules/emacs.nix
              ./modules/neovim.nix
              ./modules/ops.nix

              # programming languages
              ./modules/go.nix
              ./modules/node.nix
              ./modules/php.nix
              ./modules/python.nix
            ];
          };
        system = "x86_64-linux";
        homeDirectory = "/home/daniel";
        username = "daniel";
      };
    };

    # export the profiles for selecting them via the hash command param
    macbook-pro = self.homeConfigurations.macbook-pro.activationPackage;
    linux-desktop = self.homeConfigurations.linux-desktop.activationPackage;
  };
}
