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

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
    };

    argo-helm-updater = {
      url = "github:dj95/argo-helm-updater";
    };
  };

  # define the outputs of this flake - especially the home configurations
  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
      hyprland,
      nur,
      zjstatus,
      argo-helm-updater,
      ...
    }@inputs:
    let
      inherit (inputs.nixpkgs.lib) attrValues;

      overlays = with inputs; [
        (import ./overlays/crossplane.nix)
        (import ./overlays/gherkin-lint.nix)
        (import ./overlays/kubectx.nix)
        (import ./overlays/kustomize-quick-create.nix)
        (import ./overlays/lsp.nix)
        (import ./overlays/mutagen-compose.nix)
        (import ./overlays/yabai.nix)
        (import ./overlays/terminaltexteffects.nix)
        # (import ./overlays/zellij.nix)
        (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })
        (final: prev: { argo-helm-updater = argo-helm-updater.packages.${prev.system}.default; })
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
            }
            ++ [
              ./hosts/darwin-mbp/configuration.nix
              nur.nixosModules.nur
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
                    ./home-manager/modules/cli.nix
                    ./home-manager/modules/fish.nix
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

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/nixos-desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # import relevant modules for this configuration
              home-manager.users.daniel = {
                # set the user nix config
                xdg.configFile."nix/nix.conf".source = ./home-manager/configs/nix/nix.conf;
                nixpkgs.overlays = overlays;

                imports = [
                  hyprland.homeManagerModules.default

                  # general
                  ./home-manager/modules/hyprland.nix
                  ./home-manager/modules/cli.nix
                  ./home-manager/modules/fish.nix
                  ./home-manager/modules/git.nix
                  ./home-manager/modules/home-manager.nix
                  ./home-manager/modules/kitty.nix
                  ./home-manager/modules/nix-utilities.nix
                  ./home-manager/modules/linux-only.nix
                  ./home-manager/modules/wezterm.nix
                  ./home-manager/modules/zellij.nix

                  # development
                  ./home-manager/modules/dev.nix
                  ./home-manager/modules/neovim.nix
                  ./home-manager/modules/ops.nix

                  # programming languages
                  ./home-manager/modules/go.nix
                  ./home-manager/modules/java.nix
                  ./home-manager/modules/node.nix
                  ./home-manager/modules/php.nix
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
