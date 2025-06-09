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
          open = true;
          modesetting.enable = true;
        };
      };
      services.xserver.videoDrivers = ["nvidia"];
    };
  }
