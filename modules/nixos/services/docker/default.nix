{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;

  cfg = config.modules.services.docker;
in {
  options.modules.services.docker = {
    enable = mkEnableOption "Enable Docker";
    storageDriver = mkOption {
      type = with types; nullOr (enum ["aufs" "btrfs" "devicemapper" "overlay" "overlay2" "zfs"]);
      default = null;
      description = "Determines which storage driver to use";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      storageDriver = cfg.storageDriver;
    };

    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
