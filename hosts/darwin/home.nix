
{ config, pkgs, lib, ... }:
{
  imports = [
    ../home.nix
  ];
  home = {
      username = "martin";
      homeDirectory = "/Users/martin";
      stateVersion = "23.11";
  };
  
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/darwin/
  home.packages = with pkgs; [
      gh
      # neovim
      # zoxide
      eza
      ripgrep
      fd
      # tmux
      # lazygit
      # lazydocker


      # nushell
      # atuin
      # carapace

      go
      nodejs
      unzip
      dotnet-sdk_8
      rustup

      yabai
      skhd
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
        ".yabairc".source = ../../dotfiles-mac/yabairc;
        ".yabairc".onChange = "/etc/profiles/per-user/martin/bin/yabai --restart-service";

        ".skhdrc".source = ../../dotfiles-mac/skhdrc;
        ".skhdrc".onChange = "/etc/profiles/per-user/martin/bin/skhd --restart-service";

        ".config/wezterm".source = ../../dotfiles-mac/wezterm;

        # #TODO: Fix these
        # ".zsh".source = ~/git/personal/dotfiles/zsh;
        # ".fzfrc".source = ~/git/personal/dotfiles/fzfrc;
        # ".zshrc".source = ~/git/personal/dotfiles/zshrc;
        # ".inputrc".source = ~/git/personal/dotfiles/inputrc;
        # ".zprofile".source = ~/git/personal/dotfiles/profile;
        # ".p10k.zsh".source = ~/git/personal/dotfiles/p10k.zsh;
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
