{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xivlauncher
    gnome-secrets
  ];
}