{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/import.nix
    # ../../modules/home/import.nix
    # ../../modules/nixvim/import.nix
  ];

  config = {
    system.stateVersion = "24.05";

    modules = {
      user = {
        enable = true;
        home-manager.enable = true;
        shell.package = pkgs.fish;
      };

      system = {
        boot.grub.enable = true;

        locale = {
          extraLocales = ["ja_JP.UTF-8"];
        };

        sound.pipewire.enable = true;
        video.nvidia.enable = true;
      };

      desktop = {
        sddm.enable = true;
        hyprland.enable = true;
      };
    };
  };
}
