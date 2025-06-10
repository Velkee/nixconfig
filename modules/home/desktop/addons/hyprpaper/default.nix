{
  lib,
  config,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.desktop.hyprpaper;
in
  with lib; {
    options.modules.desktop.hyprpaper = {
      enable = mkEnableOption "Enable Hyprpaper config";
      preload = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Which wallpapers to preload";
      };
      wallpaper = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Which preloaded wallpapers to enable for what display";
      };
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        services.hyprpaper = {
          enable = true;
          settings = {
            splash = false;
            preload = cfg.preload;
            wallpaper = cfg.wallpaper;
          };
        };
      };
    };
  }
