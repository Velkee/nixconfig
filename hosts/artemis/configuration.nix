{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/import.nix
    ../../modules/home/import.nix
    ../../modules/nixvim
  ];

  config = {
    system.stateVersion = "24.05";
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
    };

    services.hardware.bolt.enable = true;
    time.timeZone = "Europe/Oslo";
    console.keyMap = "no";

    stylix = {
      enable = true;
      image = ../../wallpapers/mizuki.png;
      polarity = "dark";
      targets = {
        qt.enable = true;
      };

      fonts = {
        serif = {
          package = pkgs.source-serif;
          name = "Source Serif 4";
        };
        sansSerif = {
          package = pkgs.source-sans;
          name = "Source Sans 3";
        };
        monospace = {
          package = pkgs.nerd-fonts.fira-mono;
          name = "FiraCode Nerd Font Mono";
        };
      };

      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-dark";
        size = 24;
      };
    };

    modules = {
      user = {
        enable = true;
        home-manager.enable = true;
        ssh.enable = true;
        shell.package = pkgs.fish;
      };

      system = {
        boot.grub.enable = true;

        locale = {
          extraLocales = [
            "ja_JP.UTF-8/UTF-8"
            "nb_NO.UTF-8/UTF-8"
          ];
        };

        fonts.enable = true;

        sound.pipewire.enable = true;
        video = {
          intel = {
            enable = true;
            busId = "PCI:0:2:0";
          };
          nvidia = {
            enable = true;
            open = false;
            busId = "PCI:1:0:0";
          };
        };

        networking = {
          networkmanager = {
            enable = true;
            hostname = "artemis";
          };
          avahi.enable = true;
          tailscale.enable = true;
        };
      };

      desktop = {
        sddm.enable = true;
        hyprland = {
          enable = true;
          monitor = [
            "eDP-1, 1920x1080@60, 0x0, 1"
            "desc:Philips Consumer Electronics Company PHL 499P9, 5120x1440,-960x-1080,1"
          ];
        };
        hyprpaper = {
          enable = true;
          preload = [
            "/home/velkee/nix/wallpapers/mizuki.png"
          ];
          wallpaper = [
            "eDP-1,/home/velkee/nix/wallpapers/mizuki.png"
          ];
        };
        waybar.enable = true;
      };

      applications = {
        mpv = {
          enable = true;
          resolution = "1080p";
        };

        anki.enable = true;
        fcitx5 = {
          enable = true;
        };
        firefox.enable = true;
        gwenview.enable = true;
        kitty.enable = true;
        libreoffice.enable = true;
        obsidian.enable = true;
        steam.enable = true;
        syncthing.enable = true;
        thunar.enable = true;
        vesktop.enable = true;
        wofi.enable = true;
      };

      cli-tools = {
        git.enable = true;
        spotify_player.enable = true;
      };

      services = {
        bluetooth.enable = true;
        docker = {
          enable = true;
          storageDriver = "btrfs";
        };
        libvirtd.enable = true;
        udisks2 = {
          enable = true;
          udiskie.enable = true;
        };
        wine.enable = true;
      };
    };

    fileSystems = {
      "/".options = [
        "noatime"
        "autodefrag"
        "compress-force=zstd"
        "commit=120"
      ];
      "/home".options = [
        "noatime"
        "autodefrag"
        "compress-force=zstd"
        "commit=120"
      ];
      "/nix".options = [
        "noatime"
        "autodefrag"
        "compress-force=zstd"
        "commit=120"
      ];
      "/.swap".options = [
        "noatime"
        "autodefrag"
        "commit=120"
      ];
      "/media/storage".options = [
        "noatime"
        "autodefrag"
        "compress-force=zstd"
        "commit=120"
      ];
    };

    swapDevices = [ { device = "/.swap/swapfile"; } ];
  };
}
