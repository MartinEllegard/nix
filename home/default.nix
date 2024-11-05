{ config, pkgs, lib, dotfiles, ... }:
{
    home = {
        username = "martin";
        homeDirectory = "/Users/martin";
        stateVersion = "23.11";
    };
    
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/darwin/
    home.packages = with pkgs; [
        gh
        neovim
        zoxide
        eza
        ripgrep
        fd
        tmux
        lazygit
        lazydocker


        nushell
        starship
        atuin
        carapace

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

    home.file = 
    # let
    #     dotfiles-core = builtins.fetchGit {
    #         url = "https://github.com/martinellegard/dotfiles-core";
    #         #rev = "39c0cb7b1a9389d63fe87ef020dcb39d32f4a77d";
    #     };
    #     dotfiles-mac = builtins.fetchGit {
    #         url = "https://github.com/martinellegard/dotfiles-mac";
    #         #rev = "39c0cb7b1a9389d63fe87ef020dcb39d32f4a77d";
    #     };
    # in 
    {
        # ".config/dotfiles-core".source = dotfiles-core;
        # ".config/dotfiles-core".onChange = ''
        #     echo "Fixing swiftbar path"
        #     /usr/bin/defaults write com.ameba.Swiftbar PluginDirectory \
        #         $(/etc/profiles/per-user/martin/bin/readlink ~/.config/dotfiles)/swiftbar/scripts
        #     echo swiftbar plugin directory is $(/usr/bin/defaults read com.ameba.Swiftbar PluginDirectory)
        # '';
        # ".config/dotfiles-mac".source = dotfiles-mac;

        ".yabairc".source = ~/git/personal/dotfiles-mac/.yabairc;
        ".yabairc".onChange = "/etc/profiles/per-user/martin/bin/yabai --restart-service";

        ".skhdrc".source = ~/git/personal/dotfiles-mac/.skhdrc;
        ".skhdrc".onChange = "/etc/profiles/per-user/martin/bin/skhd --restart-service";

        #"Library/Application Support/nushell".source = ../dotfiles/nushell;
        ".config/nushell".source = ../dotfiles/nushell;
        ".config/starship".source = ../dotfiles/starship;
        ".tmux.conf".source = ~/git/personal/dotfiles-core/.tmux.conf;
        ".config/tmux".source = ~/git/personal/dotfiles-core/.config/tmux;
        ".config/wezterm".source = ~/git/personal/dotfiles-core/.config/wezterm;
        ".config/fish/".source = ~/git/personal/dotfiles-core/.config/fish;
        ".config/nvim".source = ~/git/personal/dotfiles-core/.config/nvim;

        #TODO: Fix these
        ".zsh".source = ~/git/personal/dotfiles/zsh;
        ".fzfrc".source = ~/git/personal/dotfiles/fzfrc;
        ".zshrc".source = ~/git/personal/dotfiles/zshrc;
        ".inputrc".source = ~/git/personal/dotfiles/inputrc;
        ".zprofile".source = ~/git/personal/dotfiles/profile;
        ".p10k.zsh".source = ~/git/personal/dotfiles/p10k.zsh;
    };

    #programs.home-manager.enable = true;
    programs.zsh = {
      enable = true;
      initExtra = ''
        # Add any additional configurations here
        export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
      '';
    };
}
