{
  inputs,
  pkgs,
  ...
}: {
  stylix.targets = {
    wofi.enable = true;
    hyprlock.enable = false;
  };

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

        "XCURSOR_THEME,phinger-cursors-dark"
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
          "Control_L, L, exec, hyprlock"
          ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
          "$mod, F7, exec, grim -g \"$(slurp -d)\" - | wl-copy"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

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
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        dim_special = 0.2;
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
      windowrulev2 = [
        "suppressevent fullscreen maximize, class:^(steam_app_534380)$"
        "opacity 1.0 override 1.0 override, title:.*(YouTube).*"
      ];
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
