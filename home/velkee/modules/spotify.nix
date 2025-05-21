{
  programs.spotify-player = {
    enable = true;
    settings = {
      client_id = "22d5a4dc3aaf422d805807f8231985ac";
      tracks_playback_limit = 500;
      cover_img_width = 7;
      cover_img_length = 16;
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
