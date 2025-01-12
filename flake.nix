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

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # };

    nur = {
      url = "github:nix-community/NUR";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
    };

    zj-quit = {
      url = "github:dj95/zj-quit";
    };

    zj-smart-sessions = {
      url = "github:dj95/zj-smart-sessions";
    };

    argo-helm-updater = {
      url = "github:dj95/argo-helm-updater";
    };

    kdl-fmt = {
      url = "github:dj95/kdl-fmt";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  # define the outputs of this flake - especially the home configurations
  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
      # hyprland,
      nur,
      zjstatus,
      argo-helm-updater,
      ...
    }@inputs:
    let
      inherit (inputs.nixpkgs.lib) attrValues;

      overlays = with inputs; [
        (import ./overlays/crossplane.nix)
        (import ./overlays/frizbee.nix)
        (import ./overlays/gherkin-lint.nix)
        (import ./overlays/kubectx.nix)
        (import ./overlays/kube-review.nix)
        (import ./overlays/kustomize-quick-create.nix)
        (import ./overlays/logcli.nix)
        (import ./overlays/mutagen-compose.nix)
        (import ./overlays/yabai.nix)
        (import ./overlays/sketchybar.nix)
        (import ./overlays/terminaltexteffects.nix)
        (import ./overlays/zellij.nix)
        (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })
        (final: prev: { zj-quit = zj-quit.packages.${prev.system}.default; })
        (final: prev: { zj-smart-sessions = zj-smart-sessions.packages.${prev.system}.default; })
        (final: prev: { argo-helm-updater = argo-helm-updater.packages.${prev.system}.default; })
        (final: prev: { kdl-fmt = kdl-fmt.packages.${prev.system}.default; })
        (final: prev: { ghostty = ghostty.packages.${prev.system}.default; })
      ];
    in
    # legacyPackages attribute for declarative channels (used by compat/default.nix)
    inputs.flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = inputs.nixpkgs.legacyPackages.${system};
    })
    // {
      darwinConfigurations = rec {
        Daniels-MacBook-Pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules =
            attrValues {
              configuration = import ./hosts/darwin-mbp/configuration.nix;
              defaults = import ./hosts/darwin-mbp/defaults.nix;
              general = import ./hosts/darwin-mbp/general.nix;
              yabai = import ./hosts/darwin-mbp/yabai.nix;
              aerospace = import ./hosts/darwin-mbp/aerospace.nix;
            }
            ++ [
              ./hosts/darwin-mbp/configuration.nix
              home-manager.darwinModules.home-manager
              {
                users.users.daniel.home = "/Users/daniel";

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                nixpkgs.overlays = overlays;

                home-manager.users.daniel = {
                  # set the user nix config
                  xdg.configFile."nix/nix.conf".source = ./home-manager/configs/nix/nix.conf;

                  imports = [
                    # general
                    ./home-manager/modules/aerospace.nix
                    ./home-manager/modules/cli.nix
                    ./home-manager/modules/fish.nix
                    ./home-manager/modules/ghostty.nix
                    ./home-manager/modules/git.nix
                    ./home-manager/modules/home-manager.nix
                    ./home-manager/modules/lldb.nix
                    ./home-manager/modules/nix-utilities.nix
                    ./home-manager/modules/ssh.nix
                    ./home-manager/modules/wezterm.nix
                    ./home-manager/modules/zed.nix
                    ./home-manager/modules/zellij.nix

                    # development
                    ./home-manager/modules/dev.nix
                    ./home-manager/modules/helix.nix
                    ./home-manager/modules/neovim.nix
                    ./home-manager/modules/ops.nix

                    # programming languages
                    ./home-manager/modules/go.nix
                    ./home-manager/modules/node.nix
                    ./home-manager/modules/python.nix
                    ./home-manager/modules/rust.nix
                  ];
                };
              }
            ];
        };
      };
    };
}
