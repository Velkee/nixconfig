{
  programs.firefox = {
    enable = true;
    profiles."default".settings = {
      "media.ffmpeg.vaapi.enabled" = true;
      "widget.dmabuf.force-enabled" = true;
    };
  };
}
