{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
# let shared-flake = inputs.shared-flake;
# in
{
  # imports = [
  #   shared-flake
  # ];
  home = {
    username = "martin";
    homeDirectory = "/Users/martin";
    stateVersion = "23.11";
  };

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/darwin/
  home.packages = with pkgs; [
    # Window manager
    yabai
    skhd

    # Dev tooling
  ];

  programs.git = {
    enable = true;
    userName = "Martin Ellegård";
    userEmail = "martin.ellegard@gmail.com";
    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      #safe.directory = [ "*" ];
    };
  };

  home.file = {
    ".yabairc".source = ./config/yabairc;
    ".yabairc".onChange = "/etc/profiles/per-user/martin/bin/yabai --restart-service";

    ".skhdrc".source = ./config/skhdrc;
    ".skhdrc".onChange = "/etc/profiles/per-user/martin/bin/skhd --restart-service";
  };

  #programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
