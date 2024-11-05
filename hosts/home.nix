{ config, pkgs, ... }:
{
  # Add common programs for home
  home.packages = [
    pkgs.fish

    pkgs.neovim
    pkgs.helix

    pkgs.lazygit
    pkgs.lazydocker

    pkgs.pfetch
    pkgs.tmux
    pkgs.zoxide
    pkgs.starship
  ];

  home.file =
    let
      wallpapers = builtins.fetchGit {
        url = "https://github.com/MartinEllegard/wallpapers";
        rev = "76e3f418b95f5e46f2f30a0c15c1258c1d060d1b";
      };
    in
    {
      "wallpapers/".source = wallpapers;

      ".config/fish/config.fish".source = ../dotfiles-core/fish/config.fish;
      ".config/fish/conf.d/nix.fish".source = ../dotfiles-core/fish/conf.d/nix.fish;

      ".config/nvim".source = ../dotfiles-core/nvim;
      ".config/helix".source = ../dotfiles-core/helix;

      ".config/bottom".source = ../dotfiles-core/bottom;
      ".config/btop".source = ../dotfiles-core/btop;

      ".config/starship".source = ../dotfiles-core/starship;
      ".config/tmux".source = ../dotfiles-core/tmux;
      ".tmux.conf".source = ../dotfiles-core/tmux.conf;
      ".config/zellij".source = ../dotfiles-core/zellij;
    };
}
