{ pkgs, ... }:

{
  services.unbound = {
    enable = true;
    package = pkgs.unbound-full;
    settings = {
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

        domain-insecure = "ts.net";
      };
      forward-zone = [
        {
          name = ".";
          forward-addr = [
            "1.1.1.1@853#cloudflare-dns.com"
            "1.0.0.1@853#cloudflare-dns.com"
          ];
          forward-tls-upstream = true;
        }
        {
          name = "ts.net";
          forward-addr = "100.100.100.100";
        }
      ];
      remote-control.control-enable = true;
    };
  };
}
