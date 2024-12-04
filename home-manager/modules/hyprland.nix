{ pkgs, ... }:

{
  programs.kitty.enable = true;
  programs.wofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      monitor = [
        "DP-3, 2560x1440@144, 0x0, 1, vrr, 1"
        "DP-2, 2560x1440@60, -2560x0, 1"
      ];
      exec-once = [
        "waybar"
        "fcitx5"
      ];
      env = [
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GL_GSYNC_ALLOWED,1"

        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];
      bind = [
        "$mod, Q, exec, kitty"
        "$mod, M, exit"
        "$mod, C, killactive"
        "$mod, F, exec, firefox"
        "$mod, R, exec, wofi --show drun"
        "$mod, E, exec, dolphin"
      ]
      ++ (
        builtins.concatLists (builtins.genList
          (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      input = {
        kb_layout = "no";
        accel_profile = "flat";
      };
      decoration = {
        rounding = 10;
      };
    };
  };
}
