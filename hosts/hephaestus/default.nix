{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./filesystems.nix
    ./graphics.nix

    ../modules
  ];

  fcitx5.enable = true;
  hyprland = {
    enable = true;
    monitor = [
      "eDP-1, 1920x1080@60, auto, 1"
      "DP-3, 5120x1440@60, auto, 1"
    ];
    wallpaper = {
      enable = true;
      preload = ["/home/velkee/nix/wallpapers/wallpaper-ws.png" "/home/velkee/nix/wallpapers/ligma.jpg"];
      assign = ["DP-3,/home/velkee/nix/wallpapers/wallpaper-ws.png" "eDP-1,/home/velkee/nix/wallpapers/ligma.jpg"];
    };
  };
  libvirt.enable = true;
  sddm.enable = true;
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
  services.blueman.enable = true;
}
