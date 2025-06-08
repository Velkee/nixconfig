{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.ly;
in {
  options.ly = {
    enable = mkEnableOption "Ly display manager";
  };

  config = mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
    };
  };
}
