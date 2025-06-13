{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.services.wine;
in {
  options.modules.services.wine = {
    enable = mkEnableOption "Enable the Wine compatibility layer";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wineWowPackages.stable
    ];
  };
}
