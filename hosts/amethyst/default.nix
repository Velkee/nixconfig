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
    rootless = true;
  };
  fcitx5.enable = true;
  hyprland = {
    enable = true;
    monitor = [
      "DP-3, 2560x1440@144, auto, 1"
    ];
    wallpaper = {
      enable = true;
      preload = ["/home/velkee/nix/wallpapers/mizuki.png"];
      assign = ["DP-3,/home/velkee/nix/wallpapers/mizuki.png"];
    };
  };
  libvirt.enable = true;
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

  networking.hostName = "amethyst";
  networking.wireless.iwd.enable = true;

  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "nb_NO.UTF-8/UTF-8"
  ];

  services.printing.enable = true;
  services.printing.drivers = [pkgs.gutenprint];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  networking.firewall.allowedTCPPorts = [64738];
  networking.firewall.allowedUDPPorts = [64738];
}
