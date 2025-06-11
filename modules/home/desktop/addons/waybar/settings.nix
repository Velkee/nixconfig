{
  mainBar = {
    layer = "bottom";
    position = "top";
    modules-left = [
      "hyprland/workspaces"
    ];
    modules-center = ["clock"];
    modules-right = [
      "wireplumber"
      "tray"
    ];

    "hyprland/workspaces" = {
      all-outputs = true;
    };

    clock = {
      format = "{:%H:%M}  ";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        week-pos = "right";
        format = {
          months = "<b>{}</b>";
          days = "<b>{}</b>";
          weeks = "<b>W{}</b>";
          weekdays = "<b>{}</b>";
          today = "<b><u>{}</u></b>";
        };
      };
    };
    wireplumber = {
      format = "{volume}% {icon}";
      format-muted = "";
      on-click = "pavucontrol";
      format-icons = ["" "" ""];
    };
  };
}
