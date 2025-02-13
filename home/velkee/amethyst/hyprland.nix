{
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

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        "/home/velkee/nix/home/velkee/amethyst/wallpaper.png"
      ];
      wallpaper = [
        ", /home/velkee/nix/home/velkee/amethyst/wallpaper.png"
      ];
    };
  };
}
