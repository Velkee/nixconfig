{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.services.bluetooth;
in
  with lib; {
    options.modules.services.bluetooth = {
      enable = mkEnableOption "Enable bluetooth";
    };

    config = mkIf cfg.enable {
      hardware.bluetooth = {
        enable = true;
      };

      environment.systemPackages = [
        pkgs.blueman
      ];

      services.blueman.enable = true;
    };
  }
