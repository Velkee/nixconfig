{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf lists types;
  cfg = config.modules.services.k3s;
in {
  options.modules.services.k3s = {
    enable = mkEnableOption "Enable k3s server";
    cluster = mkOption {
      description = "k3s cluster configuration";
      default = {};
      type = types.submodule {
        options = {
          enable = mkEnableOption "Enable k3s cluster mode";
          init = mkOption {
            type = types.bool;
            default = false;
            description = "Initialize a cluster";
          };
          token = mkOption {
            type = types.str;
            description = "Cluster token";
          };
          serverAddr = mkOption {
            type = types.str;
            description = "Cluster server address";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts =
        [
          6443
        ]
        ++ lists.optional (cfg.cluster.enable) [2379 2390];
      allowedUDPPorts = lists.optional (cfg.cluster.enable) [8472];
    };

    services.k3s = {
      enable = true;
      role =
        if cfg.cluster.enable
        then cfg.cluster.role
        else "server";
      token = mkIf (cfg.cluster.enable) cfg.cluster.token;
      clusterInit = mkIf (cfg.cluster.enable && cfg.cluster.init) true;
      serverAddr = mkIf (cfg.cluster.enable && !cfg.cluster.init) cfg.cluster.serverAddr;
    };
  };
}
