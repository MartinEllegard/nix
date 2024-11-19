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
