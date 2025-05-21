{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./modules
  ];

  mpv = {
    enable = true;
    resolution = "1440p";
  };

  gtk.iconTheme = {
    name = "BeautyLine";
    package = pkgs.beauty-line-icon-theme;
  };

  home.packages = with pkgs; [
    anki
    bitwarden-desktop
    blockbench
    (prismlauncher.override {
      jdks = [
        temurin-jre-bin-21
        temurin-jre-bin-17
        temurin-jre-bin-8
      ];
    })
    clonehero
    gcr
    hydrus
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.kservice
    kdePackages.gwenview
    krita
    libreoffice
    mangohud
    obsidian
    osu-lazer-bin
    pwvucontrol
    strawberry-qt6
    vesktop
    xivlauncher
    networkmanagerapplet
  ];

  services.gnome-keyring.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "/home/velkee/.ssh/id_ed25519_github";
      };
      "transcodedcatgirls.com" = {
        user = "velkee";
        port = 2020;
      };
    };
  };

  xdg.configFile = {
    "fastfetch/woa.txt".text = ''
      ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷
      ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇
      ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽
      ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕
      ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕
      ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕
      ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄
      ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕
      ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿
      ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
      ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟
      ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠
      ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙
      ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣
    '';
    "fastfetch/waifu.txt".text = ''
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣷⣤⣀⠀⠀⠀⠈⡉⠒⢲⣤⣀⣀⣤⣴⣶⣶⣿⣿⣿⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⠟⠉⠁⠀⠀⡠⠄⠂⠈⢈⡉⠉⠛⢿⣿⣿⣿⣿⣿⡟⠀⠀⠀
      ⠀⠀⠀⠀⣠⣾⣿⣿⣿⠀⠀⠀⠀⢸⣿⣿⡿⠟⠁⠀⡠⠀⠀⠀⣠⠔⠀⡠⠚⠀⡄⠀⠀⠉⠻⣿⣿⣿⠁⠀⠀⠀
      ⠀⠀⢠⣾⣿⣿⣿⡿⠋⠀⠀⠀⠀⢸⣿⠟⠃⠀⢀⠞⠀⠀⢠⠞⠁⣠⠊⠀⢀⣼⠁⣾⡀⠀⡄⠘⣿⡏⠀⠀⠀⠀
      ⠀⢠⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⢀⣶⠏⠂⢠⢀⠎⠀⠀⡰⠃⢀⣼⠃⠀⡠⢋⠇⣰⠁⢿⡄⢸⡆⢹⣇⠀⠀⠀⠀
      ⠀⣾⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⣼⡟⠀⠀⡎⣞⠀⣠⡾⢁⣾⢻⠃⣠⡞⠁⡜⡰⠃⠀⢸⡗⢒⡇⠈⣿⠀⠀⠀⠀
      ⢰⣿⣿⣿⡏⠀⠀⠀⠀⢀⡠⠞⣿⠁⣄⣰⣼⢁⡝⢳⣷⡟⠁⣼⡴⠙⠀⣼⠟⠁⠀⠀⠸⢸⠀⡇⠀⠿⠀⠀⠀⠀
      ⠘⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⣿⢰⣿⡏⢿⡟⢻⡿⢲⣿⡿⣿⣦⣤⣾⣿⣆⣁⣉⣀⡀⣸⢰⠀⠀⣾⠀⠀⠀⠀
      ⠀⢿⣿⣿⣿⡄⠀⠀⠀⠀⠀⣰⣿⣿⣿⡇⠘⣰⠈⠃⣾⡟⢡⡘⣿⡏⢸⡏⢩⣭⣽⡟⣿⣿⢻⣿⣼⣏⠀⠀⠀⠀
      ⠀⠘⣿⣿⣿⣿⣄⠀⠀⠀⡼⣏⣿⣿⣿⣿⣴⣿⣦⣼⣟⣠⣦⣄⣻⡇⣼⠇⣶⣬⣿⠁⣿⡇⢸⡿⢻⣿⡄⠀⠀⠀
      ⠀⠀⠘⢿⣿⣿⣿⣷⣦⡞⢸⣿⡟⢿⣾⡿⣿⢦⡀⠀⠉⠉⠉⠉⠛⠛⠛⠛⠻⠿⠿⢶⣬⣥⣿⣇⣾⠹⡗⠄⠀⠀
      ⠀⠀⠀⠀⠙⠻⣿⣿⣿⡅⡿⠀⢧⠘⣇⣷⣝⣆⠉⠒⠀⠀⣀⣀⣀⣀⡀⠀⠀⠀⠀⢸⡿⣁⣼⣿⣿⣠⢸⣆⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠉⢻⡙⢷⡀⠈⠳⣿⡁⢻⣿⣷⡒⠀⠀⣿⠉⠉⣻⡏⠀⠀⠤⣴⣿⣟⡿⠋⣾⠛⣿⡜⣽⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⡴⠋⠙⠶⣯⣀⡞⣁⡙⢻⣿⣿⣿⣦⣄⡀⠒⠒⠚⢀⣠⣴⣿⣯⣽⣋⣤⡾⠳⣴⣿⠿⢇⠀⠀
      ⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀⠀⢀⠭⡉⡿⠋⢹⣌⣿⣏⠻⣿⣷⣶⣿⣿⠋⢙⣿⡀⠀⢙⡏⠀⢠⠞⠙⣗⠢⡉⠀
      ⠀⠀⠀⠀⠀⠀⠸⠀⢇⠀⠃⠀⠸⡀⠈⢇⠀⡇⠙⣿⣽⠤⡉⣛⣟⢋⡇⡴⢫⡾⢿⠀⢸⠀⡔⠁⡠⠀⠀⠇⠘⡆
      ⠀⠀⠀⠀⠀⠀⢰⡇⠈⠂⢸⠶⡀⠑⣄⠘⡄⠘⣶⠟⠻⣦⣆⣠⣀⣀⣻⣷⠏⠀⢸⠀⠘⠴⢥⣎⣀⠔⣁⡴⠘⡏
      ⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠹⠄⠜⠢⣈⡦⠗⠀⠸⢴⡶⡇⠈⠀⠙⠁⠠⢿⣦⠀⠈⠳⠄⣀⠀⠉⠉⠉⠀⣄⡜⠁
    '';
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        padding.top = 2;
        source = "~/.config/fastfetch/waifu.txt";
      };
      display.separator = " -> ";
      modules = [
        "title"
        "separator"
        {
          type = "os";
          key = " OS";
          keyColor = "yellow";
          format = "{2}";
        }
        {
          type = "os";
          key = "├󱄅";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "├";
          keyColor = "yellow";
        }
        {
          "type" = "packages";
          "key" = "├󰏖";
          "keyColor" = "yellow";
        }
        {
          "type" = "shell";
          "key" = "└";
          "keyColor" = "yellow";
        }
        "break"

        {
          "type" = "wm";
          "key" = " DE/WM";
          "keyColor" = "blue";
        }
        {
          "type" = "lm";
          "key" = "├󰧨";
          "keyColor" = "blue";
        }
        {
          "type" = "icons";
          "key" = "├󰀻";
          "keyColor" = "blue";
        }
        {
          "type" = "terminal";
          "key" = "└";
          "keyColor" = "blue";
        }

        "break"
        {
          "type" = "host";
          "key" = "󰌢 PC";
          "keyColor" = "green";
        }
        {
          "type" = "cpu";
          "key" = "├󰻠";
          "keyColor" = "green";
        }
        {
          "type" = "gpu";
          "key" = "├󰍛";
          "keyColor" = "green";
        }
        {
          "type" = "disk";
          "key" = "├";
          "keyColor" = "green";
        }
        {
          "type" = "memory";
          "key" = "├󰑭";
          "keyColor" = "green";
        }
        {
          "type" = "swap";
          "key" = "├󰓡";
          "keyColor" = "green";
        }
        {
          "type" = "display";
          "key" = "├󰍹";
          "keyColor" = "green";
        }
        {
          "type" = "uptime";
          "key" = "└󰅐";
          "keyColor" = "green";
        }

        "break"
        {
          "type" = "sound";
          "key" = " SOUND";
          "keyColor" = "cyan";
        }
        {
          "type" = "player";
          "key" = "├󰥠";
          "keyColor" = "cyan";
        }
        {
          "type" = "media";
          "key" = "└󰝚";
          "keyColor" = "cyan";
        }

        "break"
        "colors"
      ];
    };
  };

  xdg.desktopEntries = {
    vesktop = {
      name = "Vesktop";
      exec = "vesktop %U --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3";
      icon = "vesktop";
      genericName = "Internet Messenger";
      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];
    };
  };
}
