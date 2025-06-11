{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.applications.fcitx5;
in
  with lib; {
    options.modules.applications.fcitx5 = {
      enable = mkEnableOption "Enable fcitx5 IME";
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        i18n.inputMethod = {
          enable = true;
          type = "fcitx5";

          fcitx5 = {
            addons = with pkgs; [
              fcitx5-mozc
            ];
            waylandFrontend = true;

            settings.inputMethod = {
              GroupOrder."0" = "Default";
              "Groups/0" = {
                Name = "Default";
                "Default Layout" = "no";
                DefaultIM = "mozc";
              };
              "Groups/0/Items/0".Name = "keyboard-no";
              "Groups/0/Items/1".Name = "mozc";
            };
          };
        };
      };
    };
  }
