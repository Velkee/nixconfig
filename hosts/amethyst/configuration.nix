{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/import.nix
    ../../modules/home/import.nix
    # ../../modules/nixvim/import.nix
  ];

  config = {
    system.stateVersion = "24.05";

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
        shell.package = pkgs.fish;
      };

      system = {
        boot.grub.enable = true;

        locale = {
          extraLocales = ["ja_JP.UTF-8"];
        };

        sound.pipewire.enable = true;
        video.nvidia.enable = true;

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
        hyprland = {
          enable = true;
          monitor = ["DP-2, 2560x1440@144, 0x0, 1, vrr, 2, bitdepth, 10" "DP-3, 2560x1440@60, -2560x0 , 1"];
        };
        hyprpaper = {
          enable = true;
          preload = ["/home/velkee/nix/wallpapers/mizu.png" "/home/velkee/nix/wallpapers/luka.png"];
          wallpaper = ["DP-2,/home/velkee/nix/wallpapers/mizu.png" "DP-3,home/velkee/nix/wallpapers/luka.png"];
        };
        waybar.enable = true;
      };

      applications = {
        firefox.enable = true;
        kitty.enable = true;
        syncthing.enable = true;
        thunar.enable = true;
        vesktop.enable = true;
      };

      cli-tools = {
        git.enable = true;
      };
    };

    fileSystems = {
      "/".options = ["compress-force=zstd" "noatime"];
      "/nix".options = ["compress-force=zstd" "noatime"];
      "/.swap".options = ["noatime"];
      "/home".options = ["compress-force=zstd" "noatime"];
      "/media/games".options = ["compress-force=zstd" "noatime"];
      "/media/storage".options = ["compress-force=zstd" "noatime"];
    };

    swapDevices = [{device = "/.swap/swapfile";}];
  };
}
