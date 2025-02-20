{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./filesystems.nix
    ./graphics.nix

    ../modules
  ];

  hyprland.enable = true;
  fcitx5.enable = true;
  libvirt.enable = true;
  steam.enable = true;
  tailscale.enable = true;
  wine.enable = true;

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
}
