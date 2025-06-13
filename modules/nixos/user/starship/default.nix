{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.modules.user.shell.starship;
in {
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
    };
  };
}
