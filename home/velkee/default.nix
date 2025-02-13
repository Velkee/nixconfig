{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./emulation.nix
    ./firefox.nix
    ./git.nix
    ./kitty.nix
    ./mpv.nix
    ./nixvim.nix
    ./hyprland.nix
    ./spotify.nix
    ./theme.nix
    ./waybar
  ];

  home.packages = with pkgs; [
    anki
    ark
    bitwarden-desktop
    clonehero
    dolphin
    gwenview
    hydrus
    krita
    mangohud
    obsidian
    osu-lazer-bin
    pwvucontrol
    strawberry-qt6
    vesktop
    xivlauncher
    (prismlauncher.override {
      jdks = [
        temurin-jre-bin
        temurin-jre-bin-17
        temurin-jre-bin-23
        temurin-jre-bin-8
      ];
    })
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
}
