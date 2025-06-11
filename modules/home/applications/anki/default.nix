{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.applications.anki;
in
  with lib; {
    options.modules.applications.anki = {
      enable = mkEnableOption "Enable Anki SSR system";
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        home.packages = [
          pkgs.anki
        ];
      };
    };
  }
