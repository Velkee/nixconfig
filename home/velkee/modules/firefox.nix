{
  programs.firefox = {
    enable = true;
    profiles."default".settings = {
      "media.ffmpeg.vaapi.enabled" = true;
      "widget.dmabuf.force-enabled" = true;
    };
  };

  stylix.targets.firefox.profileNames = ["default"];
}
