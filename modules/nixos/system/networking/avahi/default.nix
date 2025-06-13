{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.system.networking.avahi;
in {
  options.modules.system.networking.avahi = {
    enable = mkEnableOption "Enable avahi mDNS";
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;

      publish = {
        enable = true;
        addresses = true;
      };
    };
  };
}
