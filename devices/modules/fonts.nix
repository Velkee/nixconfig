{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      ipafont
      nerd-fonts.fira-code
      noto-fonts-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        serif = [
          "IPAMincho"
          "DejaVu Serif"
        ];
        sansSerif = [
          "IPAGothic"
          "DejaVu Sans"
        ];
        monospace = [ "FiraCode Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
