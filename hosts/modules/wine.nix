{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.wine;
in {
  options.wine = {
    enable = mkEnableOption "Wine translation layer";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wineWowPackages.stable
      winetricks
    ];
  };
}
