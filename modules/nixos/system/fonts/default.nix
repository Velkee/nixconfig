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
          ipaexfont
          nerd-fonts.fira-code
          noto-fonts-color-emoji
          source-han-sans-korean
          source-han-sans-simplified-chinese
          source-han-serif-korean
          source-han-serif-simplified-chinese
          source-sans
          source-serif
        ];
        description = "Fonts packages to install";
      };
      serif = mkOption {
        type = with types; listOf str;
        default = ["Source Serif 4" "IPAexMincho"];
      };
      sans = mkOption {
        type = with types; listOf str;
        default = ["Source Sans 3" "IPAexGothic"];
      };
      monospace = mkOption {
        type = with types; listOf str;
        default = ["Fira Code Nerd Font Mono"];
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
