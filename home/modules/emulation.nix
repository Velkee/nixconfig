{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mgba
    melonDS
    dolphin-emu
    # lime3ds
    ryujinx
    duckstation
    pcsx2
    ppsspp
    rpcs3
    shadps4
  ];
}
