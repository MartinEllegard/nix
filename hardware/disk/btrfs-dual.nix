# User like this in a configuration setup:
# when installing nixos: sudo nix run github:nix-community/disko -- --mode zap_create_mount ./disko-config.nix
# using remote: sudo nix run github:nix-community/disko -- --mode zap_create_mount --flake github:MartinEllegard/nix#martin-white-tower  --arg disks '[ "/dev/nvme1n1", "/dev/nvme2n1" ]'
# modules = [
#   disko.nixosModules.disko
#   ./disko-config.nix
#   {
#     _module.args.disks = [ "/dev/nvme1n1", "/dev/nvme2n1" ];
#   }
#   ./configuration.nix
# ];
{disks ? ["/dev/nvme1n1", "/dev/nvme2n1"], ...}: {
  disko.devices = {
    disk = {
      secondary = {
        type = "disk";
        device = builtins.elemAt disks 1;
        content = {
          type = "gpt";
          partitions = {
            big = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Subvolume name is the same as the mountpoint
                  "/home/martin" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home/martin/storage";
                  };
                };

                mountpoint = "/partition-secondary";
              };
            };
          };
        };

      };
      primary = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "128M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "/rootfs" = {
                    mountpoint = "/";
                  };
                  # Subvolume name is the same as the mountpoint
                  "/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  "/home/martin" = {}
                  # Parent is not mounted so the mountpoint must be set
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  # This subvolume will be created but not mounted
                  "/test" = { };
                  # Subvolume for the swapfile
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap = {
                      swapfile.size = "20M";
                      swapfile2.size = "20M";
                      swapfile2.path = "rel-path";
                    };
                  };
                };

                mountpoint = "/partition-primary";
                swap = {
                  swapfile = {
                    size = "20M";
                  };
                  swapfile1 = {
                    size = "20M";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
