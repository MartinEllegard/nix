{self, pkgs, config, ...}:
# let user = "martin"; in
{
  # The platform the configuration will be used on.
  # nixpkgs.hostPlatform = "aarch64-darwin";
  #
  # # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

  # Setup user, packages, programs
  # nix = {
  #   package = pkgs.nix;
  #   settings = {
  #     trusted-users = [ "@admin" "${user}" ];
  #     substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
  #     trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  #   };
  #
  #   gc = {
  #     user = "root";
  #     automatic = true;
  #     interval = { Weekday = 0; Hour = 2; Minute = 0; };
  #     options = "--delete-older-than 30d";
  #   };
  #
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #   '';
  # };
  #
  # system.checks.verifyNixPath = false;
  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  #system.stateVersion = 5;
  imports = [
    ./host-users.nix
    ./system-settings.nix
    ./apps.nix
  ];
}

