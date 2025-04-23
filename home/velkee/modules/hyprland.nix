{
  inputs,
  pkgs,
  ...
}: {
  programs.wofi.enable = true;
  programs.waybar = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "fcitx5"
        "hyprpaper"
        "waybar"
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
          "$mod, L, exec, hyprlock"
          ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
          "$mod, F7, exec, grim -g \"$(slurp -d)\" - | wl-copy"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod, V, togglefloating"
          "$mod SHIFT, F, fullscreen, 0"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9
        ));
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      input = {
        kb_layout = "no";
        accel_profile = "flat";

        tablet = {
          output = "current";
        };
      };
      decoration = {
        rounding = 10;
      };
      general = {
        allow_tearing = true;
      };
      windowrule = [
        "immediate, fullscreen:1"
      ];
      experimental = {
        xx_color_management_v4 = true;
      };
    };
  };

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    xorg.xsetroot
  ];

  programs.hyprlock.enable = true;
}
