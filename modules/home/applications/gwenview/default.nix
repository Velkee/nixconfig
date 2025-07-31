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
    enable = mkEnableOption "Enable Gwenview image viewer";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        kdePackages.gwenview
      ];
    };
  };
}
