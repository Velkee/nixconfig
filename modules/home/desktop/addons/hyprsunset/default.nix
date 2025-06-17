{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;

  cfg = config.modules.desktop.hyprsunset;
in {
  options.modules.desktop.hyprsunset = {
    enable = mkEnableOption "Enable hyprsunset";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      services.hyprsunset = {
        enable = true;
        transitions = {
          sunrise = {
            calendar = "*-*-* 06:00:00";
            requests = [
              ["temperature" "6500"]
            ];
          };
          sunset = {
            calendar = "*-*-* 19:00:00";
            requests = [
              ["temperature" "3500"]
            ];
          };
        };
      };
    };
  };
}
