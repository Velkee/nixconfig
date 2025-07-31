{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.modules) user;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.applications.prismlauncher;
in {
  options.modules.applications.prismlauncher = {
    enable = mkEnableOption "Enable Prism Launcher";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        (prismlauncher.override {
          jdks = [
            temurin-jre-bin
            temurin-jre-bin-17
            temurin-jre-bin-8
          ];
        })
      ];
    };
  };
}
