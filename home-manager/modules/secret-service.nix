{ pkgs, ... }:

{
  services.gnome-keyring.enable = true;
  home.packages = [ pkgs.gcr ];
}