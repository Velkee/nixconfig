{
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    iconTheme = {
      name = "BeautyLine";
      package = pkgs.beauty-line-icon-theme;
    };
    theme = {
      name = "catppuccin-mocha-pink-standard";
      package = (
        pkgs.catppuccin-gtk.override {
          accents = ["pink"];
          variant = "mocha";
        }
      );
    };
    cursorTheme = {
      name = "catppuccin-mocha-pink-cursors";
      package = pkgs.catppuccin-cursors.mochaPink;
    };
  };

  qt.enable = true;
  qt.platformTheme.name = "qtct";

  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
  ];

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
