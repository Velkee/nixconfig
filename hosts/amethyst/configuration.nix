{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/import.nix
    ../../modules/home/import.nix
    ../../modules/nixvim
  ];

  config = {
    system.stateVersion = "24.05";
    boot.kernelPackages = pkgs.linuxPackages_zen;

    time.timeZone = "Europe/Oslo";
    console.keyMap = "no";

    environment.systemPackages = with pkgs; [
      hydrus
    ];

    stylix = {
      enable = true;
      image = ../../wallpapers/mizu.png;
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

        fonts.enable = true;

        sound.pipewire.enable = true;
        video.nvidia = {
          enable = true;
          open = true;
        };

        networking = {
          networkmanager = {
            enable = true;
            hostname = "amethyst";
          };
          avahi.enable = true;
        };
      };

      desktop = {
        sddm.enable = true;
        niri.enable = true;
        hyprland = {
          enable = true;
          monitor = ["DP-5, 2560x1440@144, 0x0, 1, vrr, 2, bitdepth, 10" "DP-6, 2560x1440@60, -2560x0, 1"];
        };
        hyprpaper = {
          enable = true;
          preload = ["/home/velkee/nix/wallpapers/mizu.png" "/home/velkee/nix/wallpapers/luka.png"];
          wallpaper = ["DP-5,/home/velkee/nix/wallpapers/mizu.png" "DP-6,/home/velkee/nix/wallpapers/luka.png"];
        };
        hyprsunset.enable = true;
        waybar.enable = true;
      };

      applications = {
        mpv = {
          enable = true;
          resolution = "1440p";
        };

        anki.enable = true;
        fcitx5.enable = true;
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
        wine.enable = true;
      };
    };

    fileSystems = {
      "/".options = ["compress-force=zstd" "noatime" "autodefrag" "commit=120"];
      "/nix".options = ["compress-force=zstd" "noatime" "autodefrag" "commit=120"];
      "/.swap".options = ["noatime" "autodefrag" "commit=120"];
      "/home".options = ["compress-force=zstd" "noatime" "autodefrag" "commit=120"];
      "/media/games".options = ["compress-force=zstd" "noatime" "autodefrag" "commit=120"];
      "/media/storage".options = ["compress-force=zstd" "noatime" "autodefrag" "commit=120"];
    };

    swapDevices = [{device = "/.swap/swapfile";}];
  };
}
