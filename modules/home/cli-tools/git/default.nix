{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.cli-tools.git;
in
  with lib; {
    options.modules.cli-tools.git = {
      enable = mkEnableOption "Enable Git with it's config";
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        programs.git = {
          enable = true;
          userName = "Velkee";
          userEmail = "89312879+Velkee@users.noreply.github.com";
          signing = {
            signByDefault = true;
            key = "91DEF6D96F7258CD";
          };
          extraConfig = {
            init = {
              defaultBranch = "main";
            };
            pull = {
              rebase = false;
            };
            push = {
              autoSetupRemote = true;
            };
            diff = {
              colorMoved = "default";
            };
            rerere = {
              enabled = true;
            };
            feature = {
              manyFiles = true;
            };
            core = {
              editor = "nvim";
            };
          };
        };
        programs.gpg = {
          enable = true;
        };
        services.gpg-agent = {
          enable = true;
          pinentry.package = pkgs.pinentry-qt;
        };
      };
    };
  }
