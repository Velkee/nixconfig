{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.shell.fish;
in
  with lib; {
    options.modules.system.shell.fish = {
      enable = mkEnableOption "fish";
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        fishPlugins.colored-man-pages
      ];

      programs.fish = {
        enable = true;
      };

      environment.pathsToLink = ["/share/fish"];
    };
  }
