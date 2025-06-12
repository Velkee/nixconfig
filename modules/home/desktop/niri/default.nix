{
  lib,
  config,
  ...
}: let
  inherit (config.modules) user;
  inherit (config.networking) hostName;
  cfg = config.modules.desktop.niri;
in
  with lib; {
    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        home.file.".config/niri/config.kdl".source = ./${hostName}.kdl;
      };
    };
  }
