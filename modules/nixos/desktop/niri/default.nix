{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.desktop.niri;
in {
  options.modules.desktop.niri = {
    enable = mkEnableOption "Enable Niri, the scrolling window manager";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = [
        inputs.satellite.packages.x86_64-linux.xwayland-satellite
      ];
      sessionVariables.NIXOS_OZONE_WL = "1";
    };
    programs.niri.enable = true;
  };
}
