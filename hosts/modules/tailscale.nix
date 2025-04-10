{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.tailscale;
in {
  options.tailscale = {
    enable = mkEnableOption "Tailscale VPN";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}
