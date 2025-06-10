{
  user,
  pkgs,
  ...
}: {
  config = {
    programs.home-manager.enable = true;
    xdg.enable = true;

    gtk.iconTheme = {
      name = "BeautyLine";
      package = pkgs.beauty-line-icon-theme;
    };

    home = {
      username = "${user.name}";
      stateVersion = "24.05";
      homeDirectory = "${user.homeDir}";
    };
  };
}
