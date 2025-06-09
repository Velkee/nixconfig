{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
in
  with lib; {
    options.modules.desktop.hyprland = {
      enable = mkEnableOption "Enable Hyprland window manager";
    };

    config = mkIf cfg.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      environment = {
        systemPackages = with pkgs; [
          wl-clipboard
          xdg-utils
        ];
        sessionVariables.NIXOS_OZONE_WL = "1";
      };
    };
  }
