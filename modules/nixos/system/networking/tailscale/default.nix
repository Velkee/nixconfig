{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.networking.tailscale;
in
  with lib; {
    options.modules.system.networking.tailscale = {
      enable = mkEnableOption "Enable Tailscale";
    };

    config = mkIf cfg.enable {
      services.tailscale = {
        enable = true;
        openFirewall = true;
      };
    };
  }
