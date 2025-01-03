{ pkgs, monitors, ... }:

{
  programs.kitty.enable = true;
  programs.wofi.enable = true;
  programs.waybar = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "waybar"
        "xsetroot -cursor_name left_ptr"
      ];
      env = [
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];
      bind =
        [
          "$mod, Q, exec, kitty"
          "$mod, M, exit"
          "$mod, C, killactive"
          "$mod, F, exec, firefox"
          "$mod, R, exec, wofi --show drun"
          "$mod, E, exec, dolphin"
          ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        ));
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

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    xorg.xsetroot
  ];
}
