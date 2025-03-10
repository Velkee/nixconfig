# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f176762f-6c4a-48b7-940f-c759585f1b7b";
    fsType = "btrfs";
    options = ["subvol=root"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/f176762f-6c4a-48b7-940f-c759585f1b7b";
    fsType = "btrfs";
    options = ["subvol=nix"];
  };

  fileSystems."/.swap" = {
    device = "/dev/disk/by-uuid/f176762f-6c4a-48b7-940f-c759585f1b7b";
    fsType = "btrfs";
    options = ["subvol=swap"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/f176762f-6c4a-48b7-940f-c759585f1b7b";
    fsType = "btrfs";
    options = ["subvol=home"];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/E6AA-5EAF";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/media/games" = {
    device = "/dev/disk/by-uuid/83df2e5a-4cef-481f-8115-df3fb53b1b2f";
    fsType = "btrfs";
  };

  fileSystems."/media/storage" = {
    device = "/dev/disk/by-uuid/7abd4126-372f-49c0-8753-d905d9a479d6";
    fsType = "btrfs";
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp37s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
