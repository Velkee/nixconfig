{ pkgs, ... }:

{
  home.username = "velkee";
  home.homeDirectory = "/home/velkee";

  imports = [
    ./bundle.nix
  ];

  home.packages = with pkgs; [
    vesktop
    bitwarden-desktop
    anki
    hydrus
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
