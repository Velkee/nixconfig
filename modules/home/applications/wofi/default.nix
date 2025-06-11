{
  lib,
  config,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.applications.wofi;
in
  with lib; {
    options.modules.applications.wofi = {
      enable = mkEnableOption "Enable wofi launcher";
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        programs.wofi.enable = true;
      };
    };
  }
