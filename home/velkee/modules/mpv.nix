{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  mpvShaderDir = "${config.xdg.configHome}/mpv/shaders";
  cfg = config.mpv;
in {
  options = {
    enable = mkEnableOption "MPV media player";
    display = mkOption {
      type = types.str;
      default = 1080;
    };
  };
  config = {
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

    xdg.configFile = {
      "mpv/shaders/noise_static_luma.hook".source = builtins.fetchurl {
        url = "https://pastebin.com/raw/yacMe6EZ";
        sha256 = "1lf0kqb3yxgrx56v5171y3rkgm9wc4bpxibyz7q8f5v5252bdjyx";
      };
      "mpv/shaders/CfL_Predictions.glsl".source = let
        fetch = builtins.fetchGit {
          url = "https://github.com/Artoriuz/glsl-chroma-from-luma-prediction";
          rev = "9fdd0bc68cd8ae42a8072a7d5d098f118daa4293";
        };
      in "${fetch}/CfL_Prediction.glsl";
    };

    home.packages = with pkgs; [
      jellyfin-mpv-shim
    ];
  };
}
