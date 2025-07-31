{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.applications.thunar;
in {
  options.modules.applications.thunar = {
    enable = mkEnableOption "Enable thunar file manager";
  };

  config = mkIf cfg.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    services.tumbler.enable = true;
    services.gvfs.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.ark
      unzip
      p7zip
      pigz
      pxz
      unrar
    ];
  };
}
