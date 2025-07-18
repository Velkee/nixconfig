{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;
  cfg = config.modules.desktop.waybar;
in {
  options.modules.desktop.waybar = {
    enable = mkEnableOption "Enable waybar";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      stylix.targets.waybar.addCss = false;

      programs.waybar = {
        enable = true;

        settings = import ./settings.nix;
        style = import ./style.nix;
      };
    };
  };
}
