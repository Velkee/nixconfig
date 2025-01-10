{ pkgs, ... }:

{
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
        "hyprpaper"
        "xsetroot -cursor_name left_ptr"
      ];
      env = [
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"

        "HYPRCURSOR_THEME,Catppuccin Mocha Pink"
        "HYPRCURSOR_SIZE,32"

        "XCURSOR_THEME,catppuccin-mocha-pink-cursor"
        "XCURSOR_SIZE,24"
      ];
      bind =
        [
          "$mod, Q, exec, kitty"
          "$mod, M, exit"
          "$mod, C, killactive"
          "$mod, F, exec, firefox"
          "$mod, R, exec, wofi --show drun"
          "$mod, E, exec, dolphin"
          ", Print, exec, grim -g '$(slurp -d)' - | wl-copy"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
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

  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;
      preload = [ "/home/velkee/nix/wallpaper.png" ];

      wallpaper = ", /home/velkee/nix/wallpaper.png";
    };
  };

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    xorg.xsetroot
  ];
}
