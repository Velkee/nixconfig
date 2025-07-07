{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;

  cfg = config.modules.applications.gwenview;
in {
  options.modules.applications.gwenview = {
    enable = mkEnableOption "Enable Gwenview";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      home.packages = [
        pkgs.kdePackages.gwenview
      ];
    };
  };
}
