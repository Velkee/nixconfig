{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.openrgb;
in {
  options.openrgb = {
    enable = mkEnableOption "OpenRGB";
  };

  config = mkIf cfg.enable {
    services.hardware.openrgb.enable = true;
  };
}
