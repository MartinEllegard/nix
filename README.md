# My Nix flake
This is my full system configuration managed through nix and nix-darwin.
My experience using nix has been great and setting up my mac from scratch using just nix.

## Setup Mac OS

## Setup Linux

### Nix Setup
```bash
# Install nix package manager
sh <(curl -L https://nixos.org/nix/install) --daemon

# Create nix config dir
mkdir -p ~/.config/nix
# Create nix.conf
touch ~/.config/nix/nix.conf
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

### Setup repo
```bash
mkdir -p .config/home-manager
git clone https://github.com/martinellegard/dotnix.git ~/.config/home-manager
```

## Repo structure
This repo is structured as follows:
- `flake.nix` is the entry point for the flake
- `home.nix` is the entry point for the shared home-manager flake
- `flake.lock` is the lock file for the flake
- `config/` contains all the shared configuration files for the system apps
  - These files are typically called `dotfiles`
  - Home manager will manage these through symlinks to the appropriate location
- `hosts/` contains the configuration for each host
  - Each host has its own `$HOSTNAME.nix` file that contains hostname system settings
  - For NixOS this would also be the place that pulls in host specific nix configurations
- `systems/` contains the configuration for each system i have built support for
  - Each host has its own `config/` directory
    - This directory contains the host specific `dotfiles` files
    - Home manager will manage these through symlinks to the appropriate location
