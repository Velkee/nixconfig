{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (wineWowPackages.stableFull.override { waylandSupport = true; })
    winetricks
  ];
}