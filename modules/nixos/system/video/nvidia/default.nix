{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.video.nvidia;
in
  with lib; {
    options.modules.system.video.nvidia = {
      enable = mkEnableOption "Enable NVIDIA graphics";
      open = mkEnableOption "Enable open source kernel modules (Turing+ only)";
    };

    config = mkIf cfg.enable {
      hardware = {
        graphics = {
          enable = true;
          extraPackages = with pkgs; [
            nvidia-vaapi-driver
          ];
        };
        nvidia = {
          open = cfg.open;
          modesetting.enable = true;
        };
      };
      services.xserver.videoDrivers = ["nvidia"];
    };
  }
