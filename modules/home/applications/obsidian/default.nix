{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;

  cfg = config.modules.applications.obsidian;
in {
  options.modules.applications.obsidian = {
    enable = mkEnableOption "Enable Obsidian";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      home.packages = [
        pkgs.obsidian
      ];
    };
  };
}
