{ self, config, pkgs, lib, ... }:
{
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
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Import modules
  imports = [
    ./modules/user-setup.nix
    ./modules/system-settings.nix
    ./modules/apps.nix
  ];
}
