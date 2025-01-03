{ pkgs, ... }:

{
  gtk.enable = true;
  gtk.iconTheme = {
    name = "BeautyLine";
    package = pkgs.beauty-line-icon-theme;
  };
  gtk.theme = {
    name = "catppuccin-mocha-pink-standard";
    package = (
      pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        variant = "mocha";
      }
    );
  };
  gtk.cursorTheme = {
    name = "Catppuccin Mocha Pink";
    package = pkgs.catppuccin-cursors.mochaPink;
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
