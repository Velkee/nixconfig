{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.steam;
in {
  options.steam = {
    enable = mkEnableOption "Steam";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      protontricks.enable = true;
    };
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;

    environment.defaultPackages = with pkgs; [
      steamtinkerlaunch
      protonup-qt
    ];
  };
}
