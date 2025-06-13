{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  inherit (config.modules) user;

  home-directory = "/home/${user.name}";
in {
  options.modules.user = {
    enable = mkEnableOption "Enable user";
    name = mkOption {
      type = types.str;
      default = "velkee";
      description = "User account name";
    };
    homeDir = mkOption {
      type = types.str;
      default = "${home-directory}";
      description = "Home directory path";
    };
    home-manager.enable = mkEnableOption "Enable home-manager";
    shell = mkOption {
      description = "Shell config for user";
      type = types.submodule {
        options = {
          package = mkOption {
            type = types.package;
            default = pkgs.fish;
            description = "User shell";
          };
          starship.enable = mkOption {
            type = types.bool;
            default = true;
            description = "Enable starship";
          };
        };
      };
    };
  };

  config = mkIf user.enable {
    modules.system.shell.fish.enable = mkIf (user.shell.package == pkgs.fish) true;

    nix.settings.trusted-users = ["${user.name}"];

    users.groups.${user.name} = {};

    users.users.${user.name} = {
      isNormalUser = true;
      createHome = true;
      group = "${user.name}";
      extraGroups = ["wheel"];
      shell = user.shell.package;
    };
  };
}
