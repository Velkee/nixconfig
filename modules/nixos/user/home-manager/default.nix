{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.user.home-manager;
in
  with lib; {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    config = mkIf cfg.enable {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit inputs;
          inherit user;
        };
        users.${user.name}.imports = [./home.nix];
      };
    };
  }
