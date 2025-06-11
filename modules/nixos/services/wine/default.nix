{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.services.wine;
in
  with lib; {
    options.modules.services.wine = {
      enable = mkEnableOption "Enable the Wine compatibility layer";
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        wineWowPackages.stable
      ];
    };
  }
