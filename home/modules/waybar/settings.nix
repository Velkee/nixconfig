{
  mainBar = {
    layer = "bottom";
    position = "top";
    modules-left = [ "hyprland/workspaces" "hyprland/window" ];
    modules-center = [ "clock" ];
    modules-right = [ "wireplumber" "tray" ];

    "hyprland/workspaces" = {
      all-outputs = true;
    };

    clock = {
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        week-pos = "left";
        format = {
          months = "<b>{}</b>";
          days = "<b>{}</b>";
          weeks = "<b>W{}</b>";
          weekdays = "<b>{}</b>";
          today = "<b><u>{}</u></b>";
        };
      };
    };
  };
}
