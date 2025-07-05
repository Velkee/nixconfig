{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.system.sound.pipewire;
in {
  options.modules.system.sound.pipewire = {
    enable = mkEnableOption "Enable pipewire";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.pavucontrol
    ];

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
    hardware.firmware = with pkgs; [
      sof-firmware
    ];
  };
}
