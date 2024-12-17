{
  config,
  pkgs,
  inputs,
  ...
}:
{

  home.username = "martin";
  home.homeDirectory = "/home/martin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Install programs
  home.packages = [
    #docker-compose # Needs to be downloaded by pacman

    # IMPORTANT: These need to be downloaded by system (paru / pacman / apt)
    # pkgs.mako
    # pkgs.wl-clipboard
    # pkgs.xclip
    # pkgs.waybar

    # pkgs.gruvbox-gtk-theme
    # pkgs.gruvbox-plus-icons
    # pkgs.obs-studio

    # Create nerd font
    # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs = {
    git = {
      enable = true;
      userName = "Martin Ellegård";
      userEmail = "martin.ellegard@gmail.com";
    };
    home-manager.enable = true;
  };

  # Import dotfiles/configs
  home.file = {
    ".config/hypr".source = ./config/hypr;
    ".config/waybar".source = ./config/waybar;
    ".config/mako".source = ./config/mako;
    ".config/wofi".source = ./config/wofi;

    # enable wayland support beekeeper-studio
    # ".config/bks-flags.conf".source = ./dotfiles/beekeeper-studio/bks-flags.conf;

    ".config/foot".source = ./config/foot;

    ".config/gtk-3.0".source = ./config/gtk-3.0;
    ".config/gtk-4.0".source = ./config/gtk-4.0;
  };
}
