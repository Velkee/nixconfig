{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;

  cfg = config.modules.applications.osu-lazer;
in
{
  options.modules.applications.osu-lazer = {
    enable = mkEnableOption "Enable osu-lazer";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      home.packages = [
        pkgs.osu-lazer-bin
      ];
    };
  };
}
