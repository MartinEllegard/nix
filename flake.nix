{
  description = "Martins Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Mac modules
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # Default homebrew taps
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    # Custom homebrew taps
    nikitabobko-tap = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };


    mkAlias = {
      url = "github:cdmistman/mkAlias";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      ...
    }@inputs: # shared-flake
    let
      inherit (inputs.nix-darwin.lib) darwinSystem;
      inherit (home-manager.lib.homeManagerConfiguration) standaloneSystem;
      #inherit (inputs.nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;

      # Configuration for `nixpkgs`
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
      };

    in
    {
      # Home manager standalone systems aka non nixOs linux
      homeConfigurations."martin" = home-manager.lib.homeManagerConfiguration {

        inherit (inputs.nixpkgs.legacyPackages."x86_64-linux") pkgs;
        modules = [
          # Shared home module
          # (import shared-flake)
          ./home.nix

          # Linux specific home module
          ./systems/standalone/home.nix
        ];
      };

      # Output darwin Configuration
      darwinConfigurations = rec {
        martin-mbp = darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = self.darwinModules ++ [
            ./hosts/martin-mbp.nix
          ];
        };
      };

      # Shared modules set for all darwin systems
      darwinModules = [
        # Default config for all mac os systems
        ./systems/darwin/configuration.nix
        # Homebrew setup
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "martin";

            # Optional: Enable fully-declarative tap management
            taps = {
              "homebrew/homebrew-core" = inputs.homebrew-core;
              "homebrew/homebrew-cask" = inputs.homebrew-cask;
              "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
              "nikitabobko/homebrew-tap" = inputs.nikitabobko-tap;
            };

            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = false;
            autoMigrate = true;
          };
        }

        # Home manager setup
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = inputs;
          home-manager.users.martin.imports = [
            ./systems/darwin/home.nix
            # (import shared-flake)
            ./home.nix
          ];
        }
      ];

    };
}
