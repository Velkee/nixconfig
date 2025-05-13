{
  programs.spotify-player = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      client_id = "22d5a4dc3aaf422d805807f8231985ac";
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
