{
  lib,
  config,
  ...
}: let
  cfg = config.modules.applications.syncthing;
in
  with lib; {
    config = mkIf cfg.enable {
      networking.firewall = {
        allowedTCPPorts = [22000];
        allowedUDPPorts = [22000 21027];
      };
    };
  }
