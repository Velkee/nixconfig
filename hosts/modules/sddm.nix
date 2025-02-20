{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.sddm;
in {
  options.sddm = {
    enable = mkEnableOption "SDDM display manager" ? true;
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
