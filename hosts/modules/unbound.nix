{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.unbound;
in {
  options.unbound = {
    enable = mkEnableOption "Unbound DNS server";
    tailscale.enable = mkOption {
      type = types.bool;
      default = config.tailscale;
    };
  };

  config = mkIf cfg.enable {
    services.unbound = {
      enable = true;
      package = pkgs.unbound-full;

      settings = let
        default-zone = {
          name = ".";
          forward-addr = [
            "1.1.1.1@853#cloudflare-dns.com"
            "1.0.0.1@853#cloudflare-dns.com"
          ];
          forward-tls-upstream = true;
        };
        tailscale-zone = {
          name = "ts.net";
          forward-addr = [
            "100.100.100.100"
          ];
        };
      in {
        server = {
          interface = [
            "127.0.0.1"
            "::1"
          ];
          tls-system-cert = true;
          harden-glue = true;
          harden-dnssec-stripped = true;
          use-caps-for-id = false;
          prefetch = true;
          edns-buffer-size = 1232;
          hide-identity = true;
          hide-version = true;

          domain-insecure =
            if cfg.tailscale.enable
            then "ts.net"
            else "";
        };

        forward-zone =
          if cfg.tailscale.enable
          then [
            default-zone
            tailscale-zone
          ]
          else [
            default-zone
          ];

        remote-control.control-enable = true;
      };
    };
  };
}
