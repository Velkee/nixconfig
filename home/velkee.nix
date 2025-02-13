{
  pkgs,
  config,
  username,
  inputs,
  ...
}: let
  mpvShaderDir = "${config.xdg.configHome}/mpv/shaders";
in {
  home = {
  };

  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./modules/emulation.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/hyprland.nix
    ./modules/kitty.nix
    ./modules/mpv.nix
    ./modules/nixvim.nix
    ./modules/spotify.nix
    ./modules/theme.nix
    ./modules/vscodium.nix
    ./modules/waybar
  ];

  home.packages = with pkgs; [
    anki
    ark
    bitwarden-desktop
    clonehero
    dolphin
    gwenview
    hydrus
    krita
    mangohud
    obsidian
    osu-lazer-bin
    pwvucontrol
    strawberry-qt6
    vesktop
    xivlauncher
    (prismlauncher.override {
      jdks = [
        temurin-jre-bin
        temurin-jre-bin-17
        temurin-jre-bin-23
        temurin-jre-bin-8
      ];
    })
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-2, 2560x1440@60, -2560x0, 1"
        "DP-3, 2560x1440@144, 0x0, 1, vrr, 2"
      ];
      exec-once = [
        "fcitx5"
      ];
      env = [
        "GBM_BACKEND,nvidia-drm"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "__GL_GSYNC_ALLOWED,1"
        "__GL_VRR_ALLOWED,1"

        "MOZ_DISABLE_RDD_SANDBOX,1"
      ];
      experimental.xx_color_management_v4 = true;
    };
  };

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

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "/home/velkee/.ssh/id_ed25519_github";
      };
    };
  };
}
