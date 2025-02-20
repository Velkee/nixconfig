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
    display = mkOption {
      type = types.listOf str;
    };
  };
  config = mkIf cfg.enable {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    home-manager.users.${username} = {
      imports = [
        ../../home/velkee/hyprland.nix
      ];
    };
  };
}
