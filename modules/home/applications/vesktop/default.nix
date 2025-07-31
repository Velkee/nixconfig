{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;
  cfg = config.modules.applications.vesktop;
in
{
  options.modules.applications.vesktop = {
    enable = mkEnableOption "Enable Vesktop, the Discord client";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.vesktop = {
        enable = true;
      };
      xdg.desktopEntries = {
        vesktop = {
          name = "Vesktop";
          exec = "vesktop %U --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3";
          icon = "vesktop";
          genericName = "Internet Messenger";
          categories = [
            "Network"
            "InstantMessaging"
            "Chat"
          ];
        };
      };
    };
  };
}
