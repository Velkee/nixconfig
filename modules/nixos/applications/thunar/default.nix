{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.applications.thunar;
in
  with lib; {
    options.modules.applications.thunar = {
      enable = mkEnableOption "Enable thunar file manager";
    };

    config = mkIf cfg.enable {
      programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
      };
    };
  }
