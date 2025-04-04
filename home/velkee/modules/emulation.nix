{pkgs, ...}: {
  home.packages = with pkgs; [
    azahar
    dolphin-emu
    duckstation
    melonDS
    mgba
    pcsx2
    ppsspp
    rpcs3
    ryujinx
  ];
}
