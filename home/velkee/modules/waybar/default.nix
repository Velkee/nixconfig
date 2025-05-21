{
  stylix.targets.waybar.addCss = false;

  programs.waybar = {
    enable = true;

    settings = import ./settings.nix;
    style = import ./style.nix;
  };
}
