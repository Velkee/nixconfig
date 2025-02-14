{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../modules/fcitx5.nix
    ../modules/hyprland.nix
    ../modules/libvirt.nix
    ../modules/sddm.nix
    ../modules/steam.nix
    ../modules/tailscale.nix
    ../modules/unbound.nix
    ../modules/wine.nix

    ./filesystems.nix
    ./graphics.nix
  ];

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
}
