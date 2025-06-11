{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.networking.avahi;
in
  with lib; {
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
