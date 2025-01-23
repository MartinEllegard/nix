{
  inputs,
  pkgs,
  config,
  ...
}:
{

  #   environment.extraInit = ''
  #     export PATH=$HOME/bin:$PATH
  #   '';

  # install packages from nix's official package repository.
  environment.systemPackages = with pkgs; [
    # Shell
    pkgs.fish

    # Nix formatter
    pkgs.nixfmt-rfc-style
    #wezterm
    mkalias
  ];

  fonts.packages = with pkgs; [
    meslo-lgs-nf
    # pkgs.nerd-fonts.JetBrainsMono
    # Generate nerd font
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ];})
  ];

  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    pkgs.lib.mkForce ''
      # activateSettings -u will reload the settings from the database and apply
      # them to the current session, so we do not need to logout and login again
      # to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
      app_name=$(basename "$src")
      echo "copying $src" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  # work mac comes with brew
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # brew install
    brews = [
      # "docker-compose"
      "pkg-config"
      "octant" # kubernetes dashboard
      #"otel-desktop-viewer"
      #"openjdk"
    ];

    # brew install --cask
    # these need to be updated manually
    casks = [
      # System tools
      "tg-pro"
      "nikitabobko/tap/aerospace"

      # Dev tools
      # "homebrew/cask/docker"
      "beekeeper-studio" # Database GUI
      "orbstack" # Docker alternative
      # #"twingate"

      # Terminal (nixpkg version does not work)
      "wezterm"

      # Socials
      "discord"
      "signal"
      "microsoft-teams"

      # Browser
      "arc"
      # "zen-browser"

      # Note taking
      "obsidian"
    ];

    # mac app store
    # click
    masApps = {
      #"adobe-lightroom" = 1451544217;
      # amphetamine = 937984704;
      # kindle = 302584613;
      # tailscale = 1475387142;

      # useful for debugging macos key codes
      #key-codes = 414568915;
    };
  };
}
