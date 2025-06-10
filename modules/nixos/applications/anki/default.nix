{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.applications.anki;
in
  with lib; {
    options.modules.applications.anki = {
      enable = mkEnableOption "Enable Anki SSR system";
    };

    config = mkIf cfg.enable {
      environment.systemPackages = [
        pkgs.anki
      ];
    };
  }
