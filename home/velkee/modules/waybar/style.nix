''
  * {
    color: @base05;
  }

  window#waybar {
    background: transparent;
  }

  tooltip,
  #tray menu {
    background: @base00;
    border: 2px solid @base03;
    border-radius: 5px;
  }

  #workspaces,
  #clock,
  #wireplumber,
  #tray {
    margin: 10px 4px 4px 4px;
    padding: 4px 10px;
    border-radius: 8px;
    background: @base00;
  }

  #workspaces {
    margin-left: 10px;

  }
  #workspaces button {
    background: @base01;
    border-radius: 5px;
    padding: 0px 12px;
    margin: 4px;
  }

  #workspaces button.active {
    background: @base02;
  }

  #workspaces button.urgent {
    background: @base09;
  }

  #tray {
    margin-right: 10px;
  }
''
