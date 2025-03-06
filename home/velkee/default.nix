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
  };

  home.packages = with pkgs; [
    anki
    bitwarden-desktop
    (blender.override {
      cudaSupport = true;
    })
    blockbench
    (prismlauncher.override {
      jdks = [
        temurin-jre-bin
        temurin-jre-bin-17
        temurin-jre-bin-23
        temurin-jre-bin-8
      ];
    })
    clonehero
    hydrus
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.gwenview
    krita
    mangohud
    obsidian
    osu-lazer-bin
    pwvucontrol
    strawberry-qt6
    vesktop
    xivlauncher
  ];

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "/home/velkee/.ssh/id_ed25519_github";
      };
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
