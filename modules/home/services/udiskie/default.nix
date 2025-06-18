{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;
  cfg = config.modules.services.udisks2.udiskie;
in {
  options.modules.services.udisks2.udiskie = {
    enable = mkEnableOption "Enable udiskie user service";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      services.udiskie.enable = true;
    };
  };
}
