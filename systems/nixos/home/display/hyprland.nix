# Tell it how it is
{ pkgs, home, inputs, ... }: {
  home.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = 1;
    NIXOS_OZONE_WL = 1;
  };

  home.packages = with pkgs; [
    # utils
    acpi # hardware states
    brightnessctl # Control background
    playerctl # Control audio

    # hyprland
    (inputs.hyprland.packages."x86_64-linux".hyprland.override {
      # enableNvidiaPatches = true;
    })
    hyprpaper
    hyprlock
    hypridle
    hyprcursor

    # Notifications
    mako

    # Clipboard
    xclip
    wl-clipboard

    # Launcher
    wofi

    # Screen Capture
    grim
    slurp
  ];
}
