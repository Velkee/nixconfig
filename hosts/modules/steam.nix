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
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };
    programs.gamemode.enable = true;

    environment.defaultPackages = with pkgs; [
      steamtinkerlaunch
    ];
  };
}
