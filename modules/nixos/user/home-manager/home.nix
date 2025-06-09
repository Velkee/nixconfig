{user, ...}: {
  config = {
    programs.home-manager.enable = true;

    home = {
      username = "${user.name}";
      stateVersion = "24.05";
      homeDirectory = "${user.homeDir}";
    };
  };
}
