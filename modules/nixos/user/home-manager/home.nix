{
  user,
  pkgs,
  stateVersion,
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
      inherit stateVersion;
      username = "${user.name}";
      homeDirectory = "${user.homeDir}";
    };
  };
}
