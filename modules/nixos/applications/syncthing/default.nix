{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.modules.applications.syncthing;
in {
  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [22000 21027];
    };
  };
}
