{
  lib,
  config,
  ...
}: let
  cfg = config.modules.user.shell.starship;
in
  with lib; {
    config = mkIf cfg.enable {
      programs.starship = {
        enable = true;
      };
    };
  }
