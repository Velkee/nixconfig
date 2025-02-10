{ inputs, pkgs }:

{
  imports = [
    inputs.spicetify-nix.homeManagerMoodules.default
  ];

  home.packages = with pkgs; [
    spotify
  ];

  programs.spicetify = 
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
  };
}
