{
  config,
  lib,
  username,
  ...
}:
with lib; let
  cfg = config.docker;
in {
  options.docker = {
    enable = mkEnableOption "Docker virtualisation service";
    storageDriver = mkOption {
      type = types.nullOr (types.enum ["aufs" "btrfs" "devicemapper" "overlay" "overlay2" "zfs"]);
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

    users.users.${username} =
      if cfg.rootless
      then {
        autoSubUidGidRange = true;
      }
      else {
        extraGroups = [
          "docker"
        ];
      };

    environment.variables = mkIf (!cfg.rootless) {
      DOCKER_HOST = "unix:///run/docker.sock";
    };
  };
}
