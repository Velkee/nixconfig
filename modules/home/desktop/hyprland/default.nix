{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.modules) user;
  cfg = config.modules.desktop.hyprland;
in
  with lib; {
    options.modules.desktop.hyprland = {
      monitor = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Monitor configuration for hyprland";
      };
    };

    config = mkIf cfg.enable {
      home-manager.users.${user.name} = {
        home.packages = with pkgs; [
          grim
          slurp
        ];
        wayland.windowManager.hyprland = {
          enable = true;
          settings = {
            inherit (cfg) monitor;

            "$mod" = "SUPER";
            "$filemanager" = "thunar";

            exec-once = [
              "hyprpaper"
              "waybar"
            ];

            bind =
              [
                "$mod, Q, exec, kitty"
                "$mod, M, exit"
                "$mod, C, killactive"
                "$mod, F, exec, firefox"
                "$mod, R, exec, wofi --show drun"
                "$mod, E, exec, $filemanager"
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
          };
        };
      };
    };
  }
