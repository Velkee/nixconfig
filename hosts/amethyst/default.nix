{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./filesystems.nix
    ./graphics.nix

    ../modules
  ];

  docker = {
    enable = true;
    storageDriver = "btrfs";
  };
  hyprland = {
    enable = true;
    monitor = [
      "DP-2, 2560x1440@144, 0x0, 1, vrr, 2, bitdepth, 10"
      "DP-3, 2560x1440@60, -2560x0, 1"
    ];
    wallpaper = {
      enable = true;
      preload = [
        "/home/velkee/nix/wallpapers/mizu.png"
        "/home/velkee/nix/wallpapers/luka.png"
      ];
      assign = ["DP-2,/home/velkee/nix/wallpapers/mizu.png" "DP-3,/home/velkee/nix/wallpapers/luka.png"];
    };
  };
  libvirt.enable = true;
  openrgb.enable = true;
  ly.enable = true;
  steam.enable = true;
  tailscale.enable = true;
  wine.enable = true;
  vr.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.loader.grub = {
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.cpu.amd.updateMicrocode = true;

  networking.hostName = "amethyst";
  networking.wireless.iwd.enable = true;

  services.printing.enable = true;
  services.printing.drivers = [pkgs.gutenprint];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      (runCommand "steamrun-lib" {}
        "mkdir $out; ln -s ${steam-run.fhsenv}/usr/lib64 $out/lib")
      nss
      nspr
    ];
  };

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
