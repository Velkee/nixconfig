{
  pkgs,
  lib,
  conf,
  ...
}:
with lib; let
  cfg = conf.wine;
in {
  options.wine = {
    enable = mkEnableOption "Wine translation layer";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wine-wayland
      winetricks
    ];
  };
}
