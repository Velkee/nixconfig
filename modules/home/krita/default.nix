{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;

  cfg = config.modules.applications.krita;
in
{
  options.modules.applications.krita = {
    enable = mkEnableOption "Enable Krita";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      home.packages = [
        pkgs.krita
      ];
    };
  };
}
