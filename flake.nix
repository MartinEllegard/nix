{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    shared-flake = {
      url = "github:MartinEllegard/home-manager-shared/main";
      #inputs.nixpkgs.follows = "nixpkgs";
      flake = false;
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    mkAlias = {
      url = "github:cdmistman/mkAlias";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, mkAlias, shared-flake }:
  let
    configuration = { pkgs, ... }: {

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
        nix = {
          package = pkgs.nix;
          settings = {
            trusted-users = [ "@admin" "martin" ];
            # substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
            # trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
          };

          gc = {
            user = "root";
            automatic = true;
            interval = { Weekday = 0; Hour = 2; Minute = 0; };
            options = "--delete-older-than 30d";
          };

          extraOptions = ''
            experimental-features = nix-command flakes
          '';
        };

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in

  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."martin-mbp" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs; };
      modules = [
        configuration
        ./modules/default.nix
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "martin";

            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = true;

            autoMigrate = true;
          };
        }

        home-manager.darwinModules.home-manager
        {
          home-manager.backupFileExtension = "backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = inputs;
          home-manager.users.martin.imports = [
                ./home.nix
                (import shared-flake)
          ];
          # home-manager.users.martin.modules = [
          # shared-flake
          # ];
          # home-manager.users.martin.imports = [
          # ./modules/home.nix
          # shared-flake
          # ];
        }
      ];
    };



    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."martin-mbp".pkgs;
  };
}
