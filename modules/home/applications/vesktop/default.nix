{
  lib,
  config,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.applications.vesktop;
in
  with lib; {
    options.modules.applications.vesktop = {
      enable = mkEnableOption "Enable Vesktop, the Discord client";
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        programs.vesktop = {
          enable = true;
          vencord.settings.plugins = {
            TextReplace = {
              enabled = true;
              regexRules = [
                {
                  find = "(?<!https?:\/\/.*)([Nn])([Aa])/g";
                  replace = "$1y$2";
                  onlyIfIncludes = "";
                }
                {
                  find = "(?<!https?:\/\/.*)NyA/g";
                  replace = "NYA";
                  onlyIfIncludes = "";
                }
              ];
            };
          };
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
