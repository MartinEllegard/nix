{ pkgs, config, ... }:
{

  # https://daiderd.com/nix-darwin/manual/index.html#sec-options

  time.timeZone = "Europe/Oslo";

  system = {

    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;

    defaults = {
      # clock
      # menuExtraClock.Show24Hour = true;
      # menuExtraClock.ShowSeconds = false;

      # Custom User settings
      # https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236
      # CustomUserPreferences = {

        # Global domain settings
        # NSGlobalDomain = {
          # Disable mouse acceleration
          # FIXME: Can't really get this to work
          # Every time I run darwin-rebuild switch, Pointer acceleration is enabled
          #"com.apple.mouse.scaling" = "-1";
          #"com.apple.mouse.linear" = true;

          # Enable developer context menu for web views
          #WebKitDeveloperExtras = true;
        # };

      # };

      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/trackpad.nix
      # trackpad = {
      #   # tap to click
      #   Clicking = true;
      #   # tap-tap-drag to drag
      #   Dragging = true;
      #   # two-finger-tap right click
      #   TrackpadRightClick = true;
      # };

      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
      NSGlobalDomain = {

        # keyboard navigation in dialogs
        AppleKeyboardUIMode = 3;

        # disable press-and-hold for keys in favor of key repeat
        ApplePressAndHoldEnabled = false;

        # fast key repeat rate when hold
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
      };

      # killall Dock to make them have effect
      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
      dock = {
        autohide = true;
        magnification = true;
        # most recently used spaces
        mru-spaces = false;
        tilesize = 32;
        largesize = 96;
      };

      # Mission control spaces are seperate for each monitor
      # spaces.spans-displays = false;

      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/finder.nix
      finder = {
        # bottom status bar
        ShowStatusBar = true;
        ShowPathbar = true;

        # default to list view
        FXPreferredViewStyle = "Nlsv";
        # full path in window title
        _FXShowPosixPathInTitle = true;
      };
    };

    # error from nix-darwin without this one
    stateVersion = 5;
  };

  # touchid for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # create /etc/zshrc that loads the nix-darwin environment,
  # required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  programs.fish.enable = true;

  environment.shells = [
    pkgs.fish
    pkgs.nushell
  ];

  # load env vars set via home manager
  environment.extraInit =
    let
      homeManagerSessionVars = "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh";
    in
    ''
      [[ -f ${homeManagerSessionVars} ]] && source ${homeManagerSessionVars}
    '';
}
