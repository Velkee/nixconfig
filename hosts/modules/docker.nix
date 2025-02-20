{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.docker;
in {
  options.docker = {
    enable = mkEnableOption "Docker virtualisation service";
    storageDriver = mkOption {
      type = types.nullOr enum ["aufs" "btrfs" "devicemapper" "overlay" "overlay2" "zfs"];
      default = null;
    };
    rootless = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      storageDriver = cfg.storageDriver;
      rootless =
        if cfg.rootless
        then {
          enable = true;
          setSocketVariable = true;
        }
        else {
          enable = false;
          setSocketVariable = false;
        };
    };
  };
}
