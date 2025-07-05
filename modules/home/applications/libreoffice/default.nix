{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;
  cfg = config.modules.applications.libreoffice;
in {
  options.modules.applications.libreoffice = {
    enable = mkEnableOption "Enable LibreOffice productivity suite";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      home.packages = [
        pkgs.libreoffice
      ];
    };
  };
}
