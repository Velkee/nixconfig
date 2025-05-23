{pkgs, ...}: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
      waylandFrontend = true;
      settings.inputMethod = {
        "Groups/0" = {
          "Name" = "Default";
          "Default Layout" = "no";
          "defaultIM" = "mozc";
        };
        "Groups/0/Items/0" = {
          "Name" = "keyboard-no";
          "Layout" = "";
        };
        "Groups/0/Items/1" = {
          "Name" = "mozc";
          "Layout" = "";
        };
        "GroupOrder" = {
          "0" = "Default";
        };
      };
    };
  };
}
