{
  lib,
  config,
  ...
}: let
  cfg = config.modules.media;
in
  with lib; {
    imports = [
      ./mpv.nix
      ./steam.nix
    ];

    options.modules.media = {
      enable = mkEnableOption;
    };
  }
