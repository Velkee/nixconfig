{
  lib,
  config,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.applications.kitty;
in
  with lib; {
    options.modules.applications.kitty = {
      enable = mkEnableOption "Enable the Kitty terminal";
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        programs.kitty.enable = true;
      };
    };
  }
