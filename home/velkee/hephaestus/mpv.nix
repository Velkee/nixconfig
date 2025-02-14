{config, ...}: let
  mpvShaderDir = "${config.xdg.configHome}/mpv/shaders";
in {
  programs.mpv = {
    profiles = {
      "4k" = {
        profile-desc = "4k";
        profile-cond = "(width <=3840 and height ==2160)";
        deband = "no";
        glsl-shader = "${mpvShaderDir}/SSimDownscaler.glsl";
      };
      "1440p" = {
        profile-desc = "1440p";
        profile-cond = "(width <=2560 and height ==1440)";
      };
      full-hd = {
        profile-desc = "full-hd";
        profile-cond = "(width <=1920 and height ==1080)";
        glsl-shader = "${mpvShaderDir}/ArtCNN_C4F16.glsl";
      };
      hd = {
        profile-desc = "hd";
        profile-cond = "(width <=1280 and height ==720)";
        glsl-shader = "${mpvShaderDir}/ArtCNN_C4F16.glsl";
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
  };

  xdg.configFile."mpv/shaders/ArtCNN_C4F16.glsl".source = let
    fetch = builtins.fetchGit {
      url = "https://github.com/Artoriuz/ArtCNN";
      rev = "dfa456ffb242a07de8bd15296ffa18f018d62b93";
    };
  in "${fetch}/GLSL/ArtCNN_C4F16.glsl";
  xdg.configFile."mpv/shaders/SSimDownscaler.glsl".source = let
    fetch = builtins.fetchGit {
      url = "https://gist.github.com/36508af3ffc84410fe39761d6969be10.git";
      rev = "38992bce7f9ff844f800820df0908692b65bb74a";
    };
  in "${fetch}/SSimDownscaler.glsl";
}
