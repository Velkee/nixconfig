{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.fonts;
in
  with lib; {
    options.modules.system.fonts = {
      enable = mkEnableOption "Enable font management";
      packages = mkOption {
        type = with types; listOf package;
        default = with pkgs; [
          dejavu_fonts
          noto-fonts-color-emoji
        ];
        description = "Fonts packages to install";
      };
      serif = mkOption {
        type = with types; listOf str;
        default = ["DejaVu Serif"];
      };
      sans = mkOption {
        type = with types; listOf str;
        default = ["DejaVu Sans"];
      };
      monospace = mkOption {
        type = with types; listOf str;
        default = ["DejaVu Sans Mono"];
      };
      emoji = mkOption {
        type = with types; listOf str;
        default = ["Noto Color Emoji"];
      };
    };

    config = mkIf cfg.enable {
      fonts = {
        enableDefaultPackages = false;
        packages = cfg.packages;

        fontconfig.defaultFonts = {
          serif = cfg.serif;
          sansSerif = cfg.sans;
          monospace = cfg.monospace;
          emoji = cfg.emoji;
        };
      };
    };
  }
