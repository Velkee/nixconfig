{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.fcitx5;
in {
  options.fcitx5 = {
    enable = mkEnableOption "fcitx5 IME";
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        catppuccin-fcitx5
      ];
    };
  };
}
