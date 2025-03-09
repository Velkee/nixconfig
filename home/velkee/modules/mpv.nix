{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  mpvShaderDir = "${config.xdg.configHome}/mpv/shaders";
  SSimDownscaler = "${mpvShaderDir}/SSimDownscaler.glsl";
  ArtCNN = "${mpvShaderDir}/ArtCNN_C4F16.glsl";
  cfg = config.mpv;
in {
  options.mpv = {
    enable = mkEnableOption "MPV media player";
  };
  config = mkIf cfg.enable {
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
      profiles = {
        "4k" = {
          profile-desc = "4k";
          profile-cond = "(width <=3840 and height ==2160)";
          deband = "no";
          glsl-shader = SSimDownscaler;
        };
        "1440p" = {
          profile-desc = "1440p";
          profile-cond = "(width <=2560 and height ==1440)";
        };
        full-hd = {
          profile-desc = "full-hd";
          profile-cond = "(width <=1920 and height ==1080)";
          glsl-shader = ArtCNN;
        };
        hd = {
          profile-desc = "hd";
          profile-cond = "(width <=1280 and height ==720)";
          glsl-shader = ArtCNN;
        };
        sdtv-ntcs = {
          profile-desc = "sdtv-ntcs";
          profile-cond = "(height ==480)";
          glsl-shader = ArtCNN;
        };
        sdtv-pal = {
          profile-desc = "sdtv-pal";
          profile-cond = "(height ==576)";
          glsl-shader = ArtCNN;
        };
      };
    };

    xdg.configFile = with pkgs; {
      "mpv/shaders/noise_static_luma.hook".source = builtins.fetchurl {
        url = "https://pastebin.com/raw/yacMe6EZ";
        sha256 = "1lf0kqb3yxgrx56v5171y3rkgm9wc4bpxibyz7q8f5v5252bdjyx";
      };
      "mpv/shaders/CfL_Predictions.glsl".source = let
        fetch = fetchFromGitHub {
          owner = "Artoriuz";
          repo = "glsl-chroma-from-luma-prediction";
          rev = "9fdd0bc68cd8ae42a8072a7d5d098f118daa4293";
          hash = "sha256-sbvFg8985gHZyYvbz0JEYVewBwXLb8kRja3a1LCZBnw=";
        };
      in "${fetch}/CfL_Prediction.glsl";
      "mpv/shaders/ArtCNN_C4F16.glsl".source = let
        fetch = fetchFromGitHub {
          owner = "Artoriuz";
          repo = "ArtCNN";
          rev = "v1.2.3";
          hash = "sha256-D1FVz4v5RUgNqnmmgjQ7DDQyZZFFVHQsBNyXJ4Sft7s=";
        };
      in "${fetch}/GLSL/ArtCNN_C4F16.glsl";
      "mpv/shaders/SSimDownscaler.glsl".source = let
        fetch = builtins.fetchGit {
          url = "https://gist.github.com/36508af3ffc84410fe39761d6969be10.git";
          rev = "38992bce7f9ff844f800820df0908692b65bb74a";
        };
      in "${fetch}/SSimDownscaler.glsl";
    };

    home.packages = with pkgs; [
      jellyfin-mpv-shim
    ];
  };
}
