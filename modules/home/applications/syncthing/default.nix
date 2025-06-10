{
  lib,
  config,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.applications.syncthing;
in
  with lib; {
    options.modules.applications.syncthing = {
      enable = mkEnableOption "Enable Syncthing";
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        services.syncthing = {
          enable = true;
        };
      };
    };
  }
