{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.services.udisks2;
in {
  options.modules.services.udisks2 = {
    enable = mkEnableOption "Enable udisks2 service";
  };

  config = mkIf cfg.enable {
    services.udisks2.enable = true;
  };
}
