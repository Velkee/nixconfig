{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;

  cfg = config.modules.system.video.nvidia;
in {
  options.modules.system.video.nvidia = {
    enable = mkEnableOption "Enable NVIDIA graphics";
    open = mkEnableOption "Enable open source kernel modules (Turing+ only)";
    busId = mkOption {
      type = types.str;
      description = "Bus ID for NVIDIA GPU";
    };
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
