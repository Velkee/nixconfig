{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./filesystems.nix
    ./graphics.nix

    ../modules
  ];

  hyprland = {
    enable = true;
    monitor = [
      "eDP-1, 1920x1080@60, auto, 1"
      "DP-3, 5120x1440@60, auto, 1, vrr, 2, bitdepth, 10"
    ];
    wallpaper = {
      enable = true;
      preload = ["/home/velkee/nix/wallpapers/chuuni-ws.png" "/home/velkee/nix/wallpapers/ligma.jpg"];
      assign = ["DP-3,/home/velkee/nix/wallpapers/chuuni-ws.png" "eDP-1,/home/velkee/nix/wallpapers/ligma.jpg"];
    };
  };
  libvirt.enable = true;
  sddm.enable = true;
  steam.enable = true;
  tailscale.enable = true;
  wine.enable = true;
  docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "usbcore.quirks=0bda:8153:k"
  ];

  networking.hostName = "hephaestus";
  networking.networkmanager.enable = true;

  services.hardware.bolt.enable = true;
  services.tlp.enable = true;
  services.thermald.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

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

      sizes = {
        applications = 14;
        desktop = 12;
        popups = 12;
        terminal = 14;
      };
    };

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };
  };
}
