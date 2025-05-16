{
  programs.spotify-player = {
    enable = true;
    settings = {
      client_id = "22d5a4dc3aaf422d805807f8231985ac";
      theme = "catppuccin-mocha";
      tracks_playback_limit = 500;
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
}
