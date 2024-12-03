{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      ipafont
      nerd-fonts.fira-code
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Serif" "IPAMincho" ];
        sansSerif = [ "DejaVu Sans" "IPAGothic" ];
        monospace = [ "FiraCode Nerd Font Mono" ];
      };
    };
  };
}
