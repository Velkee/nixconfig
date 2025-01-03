{ pkgs, ... }:

{
  gtk.enable = true;
  gtk.iconTheme = {
    name = "BeautyLine";
    package = pkgs.beauty-line-icon-theme;
  };

  qt.enable = true;
  qt.platformTheme.name = "qtct";
  qt.style = {
    name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/catppuccin-mocha-pink".source = "${
      (pkgs.catppuccin-kvantum.override {
        accent = "pink";
        variant = "mocha";
      })
    }/share/Kvantum/catppuccin-mocha-pink";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=catppuccin-mocha-pink";
  };
}
