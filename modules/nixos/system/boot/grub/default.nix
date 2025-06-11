{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.boot.grub;
in
  with lib; {
    options.modules.system.boot.grub = {
      enable = mkEnableOption "Enable grub bootloader";
    };

    config = mkIf cfg.enable {
      boot.loader = {
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
        };
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      };
    };
  }
