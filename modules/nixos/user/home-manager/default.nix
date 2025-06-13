{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules) user;
  cfg = config.modules.user.home-manager;
in {
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
        inherit (config.system) stateVersion;
      };
      users.${user.name}.imports = [./home.nix];
    };
  };
}
