{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.applications.steam;
in
  with lib; {
    options.modules.applications.steam = {
      enable = mkEnableOption "Enable Steam";
    };

    config = mkIf cfg.enable {
      programs.steam = {
        enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };
  }
