{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;
  cfg = config.modules.applications.wofi;
in {
  options.modules.applications.wofi = {
    enable = mkEnableOption "Enable wofi launcher";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.wofi.enable = true;
    };
  };
}
