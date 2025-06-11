{
  lib,
  config,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.cli-tools.spotify_player;
in
  with lib; {
    options.modules.cli-tools.spotify_player = {
      enable = mkEnableOption "Enable spotify_player";
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        programs.spotify-player = {
          enable = true;
          settings = {
            client_id = "22d5a4dc3aaf422d805807f8231985ac";
            tracks_playback_limit = 500;
            cover_img_width = 10;
            cover_img_length = 20;
            copy_command = {
              command = "wl-copy";
              args = [];
            };
            device = {
              volume = 100;
              audio_cache = true;
              normalization = true;
            };
          };
        };
      };
    };
  }
