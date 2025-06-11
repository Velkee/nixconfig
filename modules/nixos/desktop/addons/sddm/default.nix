{
  lib,
  config,
  ...
}: let
  cfg = config.modules.desktop.sddm;
in
  with lib; {
    options.modules.desktop.sddm = {
      enable = mkEnableOption "Enable SDDM";
    };

    config = mkIf cfg.enable {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  }
