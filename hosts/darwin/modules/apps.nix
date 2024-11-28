{ inputs, pkgs, config, ... }: {

#   environment.extraInit = ''
#     export PATH=$HOME/bin:$PATH
#   '';

# install packages from nix's official package repository.
environment.systemPackages = with pkgs; [
    pkgs.fish
    #wezterm
    mkalias
];


fonts.packages = [
    # Generate nerd font
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ];})
];

system.activationScripts.applications.text = let
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

  # To make this work, homebrew need to be installed manually, see
  # https://brew.sh The apps installed by homebrew are not managed by nix, and
  # not reproducible!  But on macOS, homebrew has a much larger selection of
  # apps than nixpkgs, especially for GUI apps!

  # work mac comes with brew
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # taps = [ "CtrlSpice/homebrew-otel-desktop-viewer" ];

    # brew install
    brews = [ 
      "docker-compose"
      "pkg-config"
      #"otel-desktop-viewer" 
      #"openjdk"
    ];

    # brew install --cask
    # these need to be updated manually
    casks = [ 
      # System tools
      "tg-pro"
      
      # Dev tools
      "homebrew/cask/docker"
      "beekeeper-studio"
      "rider"

      # Terminal (nixpkg version does not work)
      "wezterm"

      # Socials
      "discord"

      # Browser
      "arc"
      "zen-browser"

      # Note taking
      "obsidian"


      # Entertainment
      #"battle-net"
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
