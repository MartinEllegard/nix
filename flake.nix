{
  description = "Martins Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # shared-flake = {
    #   url = "github:MartinEllegard/home-manager-shared/main";
    #   #inputs.nixpkgs.follows = "nixpkgs";
    #   flake = false;
    # };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    mkAlias = {
      url = "github:cdmistman/mkAlias";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nix-darwin, nixpkgs, nix-homebrew, home-manager,  ...}@inputs: #shared-flake
  let
    inherit (inputs.nix-darwin.lib) darwinSystem;
    inherit (home-manager.lib.homeManagerConfiguration) standaloneSystem;
    #inherit (inputs.nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;

    # Configuration for `nixpkgs`
    nixpkgsConfig = {
      config = { allowUnfree = true; };
    };
  in
  {
    # Home manager standalone systems aka non nixOs linux
    homeConfigurations."martin" = standaloneSystem {
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

          # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
          mutableTaps = true;

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
