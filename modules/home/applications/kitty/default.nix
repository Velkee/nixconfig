{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;
  cfg = config.modules.applications.kitty;
in {
  options.modules.applications.kitty = {
    enable = mkEnableOption "Enable the Kitty terminal";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.kitty.enable = true;
    };
  };
}
