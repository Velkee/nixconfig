{ pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ./wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.catppuccin-cursors.mochaPink;
      name = "catppuccin-mocha-pink-cursors";
    };
  };
}
