{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.modules) user;
  cfg = config.modules.user.ssh;
in {
  options.modules.user.ssh = {
    enable = mkEnableOption "Enable SSH and config for user";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.ssh = {
        enable = true;
        forwardAgent = true;
        addKeysToAgent = "yes";
        matchBlocks = {
          "github.com" = {
            identitiesOnly = true;
            identityFile = "~/.ssh/id_ed25519_github";
          };
        };
      };
    };
  };
}
