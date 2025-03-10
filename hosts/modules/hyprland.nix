{
  config,
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
with lib; let
  cfg = config.hyprland;
in {
  options.hyprland = {
    enable = mkEnableOption "Hyprland WM";
    monitor = mkOption {
      type = types.listOf types.str;
      default = [", preferred, auto, 1"];
    };

    wallpaper.enable = mkEnableOption "Hyprpaper wallpaper service";
    wallpaper.preload = mkOption {
      type = types.listOf types.str;
    };
    wallpaper.assign = mkOption {
      type = types.listOf types.str;
    };
  };
  config = mkIf cfg.enable {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    environment.defaultPackages = with pkgs; [
      vulkan-hdr-layer-kwin6
    ];

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    home-manager.users.${username} = {
      imports = [
        ../../home/velkee/modules/hyprland.nix
      ];

      wayland.windowManager.hyprland.settings = {
        monitor = cfg.monitor;
      };

      services.hyprpaper = mkIf cfg.wallpaper.enable {
        enable = true;

        settings = {
          preload = cfg.wallpaper.preload;
          wallpaper = cfg.wallpaper.assign;
        };
      };
    };
  };
}
