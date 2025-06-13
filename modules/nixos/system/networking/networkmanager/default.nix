{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;

  cfg = config.modules.system.networking.networkmanager;
in {
  options.modules.system.networking.networkmanager = {
    enable = mkEnableOption "Enable networking through NetworkManager";
    hostname = mkOption {
      type = types.str;
      default = "nixos";
      description = "Hostname for the system";
    };
  };
  config = mkIf cfg.enable {
    networking = {
      hostName = cfg.hostname;
      networkmanager = {
        enable = true;
      };
    };
  };
}
