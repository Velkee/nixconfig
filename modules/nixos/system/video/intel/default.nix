{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.system.video.intel;
  nvidia = config.modules.system.video.nvidia;
in
{
  options.modules.system.video.intel = {
    enable = mkEnableOption "Enable Intel graphics";
    busId = mkOption {
      type = types.str;
      description = "Bud ID of Intel GPU";
    };
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.nvidia.prime = mkIf nvidia.enable {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = cfg.busId;
      nvidiaBusId = nvidia.busId;
    };
  };
}
