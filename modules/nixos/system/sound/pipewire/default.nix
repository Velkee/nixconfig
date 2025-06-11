{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.sound.pipewire;
in
  with lib; {
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
    };
  }
