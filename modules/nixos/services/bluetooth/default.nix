{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.services.bluetooth;
in {
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
