{pkgs, ...}: {
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
  fcitx5.enable = true;
  hyprland = {
    enable = true;
    monitor = [
      "DP-2, 2560x1440@144, 0x0, 1, vrr, 2, bitdepth, 10"
      "DP-3, 2560x1440@60, -2560x0, 1"
    ];
    wallpaper = {
      enable = true;
      preload = [
        "/home/velkee/nix/wallpapers/mizuki.png"
        "/home/velkee/nix/wallpapers/luka.png"
      ];
      assign = ["DP-2,/home/velkee/nix/wallpapers/mizuki.png" "DP-3,/home/velkee/nix/wallpapers/luka.png"];
    };
  };
  libvirt.enable = true;
  openrgb.enable = true;
  sddm.enable = true;
  steam.enable = true;
  tailscale.enable = true;
  wine.enable = true;

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
}
