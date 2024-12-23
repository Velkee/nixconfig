{ pkgs, config, monitors, ... }:

let mpvShaderDir = "${config.xdg.configHome}/mpv/shaders";
in {
  programs.mpv = {
    enable = true;
    config = {
      profile = "high-quality";

      keep-open = "yes";
      autofit = "50%";

      osd-bar = "no";

      alang = "jpn,eng";
      slang = "eng";

      vo = "gpu-next";
      gpu-api = "vulkan";
      gpu-context = "waylandvk";
      hwdec = "auto";

      audio-file-auto = "fuzzy";
      audio-channels = "stereo";

      demuxer-mkv-subtitle-preroll = "yes";
      blend-subtitles = "yes";
      sub-fix-timing = "yes";
      sub-auto = "fuzzy";
      sub-blur = 0.1;

      deband = "yes";
      deband-iterations = 4;
      deband-threshold = 25;
      deband-range = 16;
      deband-grain = 0;

      dither-depth = "auto";
      temporal-dither = "yes";
      dither = "fruit";

      scale-antiring = 0.6;

      target-prim = "auto";
      target-trc = "auto";
      video-output-levels = "full";

      video-sync = "display-resample";
      interpolation = "yes";
      tscale = "oversample";

      glsl-shader = [
        "${mpvShaderDir}/noise_static_luma.hook"
        "${mpvShaderDir}/CfL_Predictions.glsl"
      ];
    };
    profiles = {
      "4k" = {
        profile-desc = "4k";
        profile-cond = "(width <=3840 and height ==2160)";
        deband = "no";
        glsl-shader =
          if monitors.mainHeight < 2160 then
            "${mpvShaderDir}/SSimDownscaler.glsl"
          else
            "";
      };
      "1440p" = {
        profile-desc = "1440p";
        profile-cond = "(width <=2560 and height ==1440)";
        glsl-shader =
          if monitors.mainHeight < 1440 then
            "${mpvShaderDir}/SSimDownscaler.glsl"
          else if monitors.mainHeight > 1440 then
            "${mpvShaderDir}/ArtCNN_C4F16.glsl"
          else
            "";
      };
      full-hd = {
        profile-desc = "full-hd";
        profile-cond = "(width <=1920 and height ==1080)";
        glsl-shader =
          if monitors.mainHeight < 1080 then
            "${mpvShaderDir}/SSimDownscaler.glsl"
          else if monitors.mainHeight > 1080 then
            "${mpvShaderDir}/ArtCNN_C4F16.glsl"
          else
            "";
      };
      hd = {
        profile-desc = "hd";
        profile-cond = "(width <=1280 and height ==720)";
        glsl-shader =
          if monitors.mainHeight < 720 then
            "${mpvShaderDir}/SSimDownscaler.glsl"
          else if monitors.mainHeight > 720 then
            "${mpvShaderDir}/ArtCNN_C4F16.glsl"
          else
            "";
      };
      sdtv-ntcs = {
        profile-desc = "sdtv-ntcs";
        profile-cond = "(height ==480)";
        glsl-shader = "${mpvShaderDir}/ArtCNN_C4F16.glsl";
      };
      sdtv-pal = {
        profile-desc = "sdtv-pal";
        profile-cond = "(height ==576)";
        glsl-shader = "${mpvShaderDir}/ArtCNN_C4F16.glsl";
      };
    };
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      mpvacious
    ];
    scriptOpts = {
      subs2srs = {
        deck_name = "Lapis";
        model_name = "Lapis";
        audio_field = "ExpressionAudio";
        image_field = "Picture";
        note_tag = "アニメ::%n";

        autoclip_method = "clipboard";

        snapshot_format = "webp";
      };
    };
  };

  xdg.configFile."mpv/shaders/noise_static_luma.hook".source = builtins.fetchurl {
    url = "https://pastebin.com/raw/yacMe6EZ";
    sha256 = "1lf0kqb3yxgrx56v5171y3rkgm9wc4bpxibyz7q8f5v5252bdjyx";
  };
  xdg.configFile."mpv/shaders/CfL_Predictions.glsl".source =
    let
      fetch = builtins.fetchGit {
        url = "https://github.com/Artoriuz/glsl-chroma-from-luma-prediction";
        rev = "9fdd0bc68cd8ae42a8072a7d5d098f118daa4293";
      };
    in
    "${fetch}/CfL_Prediction.glsl";
  xdg.configFile."mpv/shaders/ArtCNN_C4F16.glsl".source =
    let
      fetch = builtins.fetchGit {
        url = "https://github.com/Artoriuz/ArtCNN";
        rev = "dfa456ffb242a07de8bd15296ffa18f018d62b93";
      };
    in
    "${fetch}/GLSL/ArtCNN_C4F16.glsl";
  xdg.configFile."mpv/shaders/SSimDownscaler.glsl".source =
    let
      fetch = builtins.fetchGit {
        url = "https://gist.github.com/36508af3ffc84410fe39761d6969be10.git";
        rev = "38992bce7f9ff844f800820df0908692b65bb74a";
      };
    in
    "${fetch}/SSimDownscaler.glsl";

  home.packages = with pkgs; [
    jellyfin-mpv-shim
  ];
}
