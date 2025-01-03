{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system.nix
    ../../modules/hyprland.nix
    ../../modules/fcitx5.nix
    ../../modules/sddm.nix
    ../../modules/steam.nix
    ../../modules/tailscale.nix
    ../../modules/unbound.nix
    ../../modules/wine.nix
    
    ./filesystems.nix
    ./graphics.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "amethyst"; # Define your hostname.
  networking.wireless.iwd.enable = true;

  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "nb_NO.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
