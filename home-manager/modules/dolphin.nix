{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dolphin
    gwenview
  ];
}
