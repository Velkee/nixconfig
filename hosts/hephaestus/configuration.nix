{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/import.nix
    ../../modules/home/import.nix
    ../../modules/nixvim
  ];

  config = {
    system.stateVersion = "24.11";
    boot.kernelPackages = pkgs.linuxPackages_zen;

    services.hardware.bolt.enable = true;
    time.timeZone = "Europe/Oslo";
    console.keyMap = "no";

    networking.hosts = {
      "192.168.122.2" = ["ipa-1.test.internal"];
    };

    stylix = {
      enable = true;
      image = ../../wallpapers/chuuni-ws.png;
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
        home-manager. enable = true;
        ssh.enable = true;
        shell.package = pkgs.fish;
      };

      system = {
        boot.grub.enable = true;

        locale = {
          extraLocales = ["ja_JP.UTF-8/UTF-8"];
        };

        fonts.enable = true;

        sound.pipewire.enable = true;
        video.nvidia = {
          enable = true;
          open = false;
        };

        networking = {
          networkmanager = {
            enable = true;
            hostname = "hephaestus";
          };
          avahi.enable = true;
          tailscale.enable = true;
        };
      };

      desktop = {
        sddm.enable = true;
        niri.enable = true;
        hyprland = {
          enable = true;
          monitor = ["desc:Philips Consumer Electronics Company PHL 499P9, 5120x1440@60, 1920x0, 1, vrr, 2, bitdepth, 10" "eDP-1, 1920x1080@60, 0x0, 1"];
        };
        hyprpaper = {
          enable = true;
          preload = ["/home/velkee/nix/wallpapers/chuuni-ws.png" "/home/velkee/nix/wallpapers/ligma.jpg"];
          wallpaper = ["desc:Philips Consumer Electronics Company PHL 499P9,/home/velkee/nix/wallpapers/chuuni-ws.png" "eDP-1,/home/velkee/nix/wallpapers/ligma.jpg"];
        };
        waybar.enable = true;
      };

      applications = {
        mpv = {
          enable = true;
          resolution = "1440p";
        };

        anki.enable = true;
        fcitx5 = {
          enable = true;
        };
        firefox.enable = true;
        kitty.enable = true;
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
        k3s.enable = true;
        libvirtd.enable = true;
        udisks2 = {
          enable = true;
          udiskie.enable = true;
        };
        wine.enable = true;
      };
    };

    fileSystems = {
      "/".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/.snapshots".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/home".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/nix".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/opt".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/root".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/srv".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/swap".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/tmp".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/usr/local".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/var".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/var/lib/libvirt/images".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/var/lib/machines".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
      "/var/tmp".options = ["noatime" "autodefrag" "compress-force=zstd" "commit=120"];
    };

    swapDevices = [{device = "/swap/swapfile";}];
  };
}
