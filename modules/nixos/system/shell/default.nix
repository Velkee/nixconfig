{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.system.shell.fish;
in {
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
